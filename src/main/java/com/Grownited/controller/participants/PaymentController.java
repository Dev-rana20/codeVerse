package com.Grownited.controller.participants;

import java.time.LocalDate;
import java.util.List;
import java.util.UUID;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.Grownited.entity.HackathonEntity;
import com.Grownited.entity.HackathonRegistrationEntity;
import com.Grownited.entity.UserEntity;
import com.Grownited.repository.HackathonRegistrationRepository;
import com.Grownited.repository.HackathonRepository;

import jakarta.servlet.http.HttpSession;

@Controller
public class PaymentController {

	@Autowired
	private HackathonRepository hackathonRepository;

	@Autowired
	private HackathonRegistrationRepository registrationRepository;

	// Demo purpose: Simple checkout without Razorpay order
	@GetMapping("/hackathons/{hackathonId}/checkout")
	public String checkout(@PathVariable Integer hackathonId, Model model, HttpSession session) {
		UserEntity user = (UserEntity) session.getAttribute("user");
		if (user == null) {
			return "redirect:/login";
		}

		HackathonEntity hack = hackathonRepository.findById(hackathonId).orElseThrow();

		// Check if registration is closed or hackathon completed
		String status = hack.getStatus();
		if ("Close".equalsIgnoreCase(status) || "CLOSED".equalsIgnoreCase(status) || "COMPLETED".equalsIgnoreCase(status)) {
			return "redirect:/hackathonDetail/" + hackathonId;
		}

		// If it's already registered, redirect back
		boolean exists = registrationRepository.existsByUserUserIdAndHackathonHackathonId(user.getUserId(), hackathonId);
		if (exists) {
			return "redirect:/hackathonDetail/" + hackathonId;
		}

		model.addAttribute("hack", hack);
		model.addAttribute("user", user);
		model.addAttribute("amount", hack.getFee());

		return "participants/Payment";
	}

	// Demo purpose: Simulate payment success
	@PostMapping("/hackathons/{hackathonId}/pay")
	public String simulatePayment(@PathVariable Integer hackathonId, 
			@RequestParam(value = "razorpay_payment_id", required = false) String paymentId,
			HttpSession session, RedirectAttributes redirectAttributes) {
		
		UserEntity user = (UserEntity) session.getAttribute("user");
		if (user == null) {
			return "redirect:/login";
		}

		HackathonEntity hackathon = hackathonRepository.findById(hackathonId).orElseThrow();

		// Check if already registered or closed
		String status = hackathon.getStatus();
		if ("Close".equalsIgnoreCase(status) || "CLOSED".equalsIgnoreCase(status) || "COMPLETED".equalsIgnoreCase(status)) {
			redirectAttributes.addFlashAttribute("error", "Registrations are no longer accepted!");
			return "redirect:/hackathonDetail/" + hackathonId;
		}

		boolean exists = registrationRepository.existsByUserUserIdAndHackathonHackathonId(user.getUserId(), hackathonId);
		if (!exists) {
			HackathonRegistrationEntity reg = new HackathonRegistrationEntity();
			reg.setUser(user);
			reg.setHackathon(hackathon);
			reg.setRegistrationDate(LocalDate.now());
			
			// Store dummy payment info
			String finalPaymentId = (paymentId != null) ? paymentId : "PAY_" + UUID.randomUUID().toString().substring(0, 8).toUpperCase();
			reg.setPaymentId(finalPaymentId);
			reg.setAmount(hackathon.getFee());

			registrationRepository.save(reg);
			
			return "redirect:/paymentSuccess/" + reg.getHackathonRegistrationId();
		} else {
			redirectAttributes.addFlashAttribute("error", "Already registered!");
			return "redirect:/hackathonDetail/" + hackathonId;
		}
	}

	@GetMapping("/paymentSuccess/{registrationId}")
	public String paymentSuccess(@PathVariable Integer registrationId, Model model, HttpSession session) {
		UserEntity user = (UserEntity) session.getAttribute("user");
		if (user == null) return "redirect:/login";

		HackathonRegistrationEntity reg = registrationRepository.findById(registrationId).orElseThrow();
		
		// Security: verify if the registration belongs to the current user
		if (!reg.getUser().getUserId().equals(user.getUserId())) {
			return "redirect:/userHome";
		}

		model.addAttribute("reg", reg);
		return "participants/PaymentSuccess";
	}

	@GetMapping("/paymentHistory")
	public String paymentHistory(Model model, HttpSession session) {
		UserEntity user = (UserEntity) session.getAttribute("user");
		if (user == null) return "redirect:/login";

		// Fetch all registrations (which are essentially the payments in this context)
		List<HackathonRegistrationEntity> myPayments = registrationRepository.findByUserUserId(user.getUserId());
		
		model.addAttribute("payments", myPayments);
		return "participants/PaymentHistory";
	}
}
