# Ruby Security Field Guide
Vulnerabilities in Ruby applications have been discovered with the potential to affect vast swathes of the Internet and attract attackers to lucrative targets online.

These vulnerabilities take advantage of features and common idioms such as serialization and deserialization of data in the YAML format. Nearly all large, tested and trusted open-source Ruby projects contain some of these vulnerabilities.

**Few developers are aware of the risks.**

In these exercises, you’ll cover recent Ruby vulnerabilities classes and their root causes. You’ll see demonstrations and develop real-world exploits. You’ll study the patterns behind the vulnerabilities and develop software engineering strategies to avoid these vulnerabilities in your projects.

**You Will Learn**
* The mechanics and root causes of past Rails vulnerabilities
* Methods for mitigating the impact of deserialization flaws
* Rootkit techniques for Rack-based applications via YAML deserialization
* Mitigations techniques for YAML deserialization flaws
* Defensive Ruby programming techniques
* Advanced testing techniques and fuzzing with Mutant

We’ve structured this field guide so you can learn as quickly as you want, but if you have questions along the way, contact us. If there’s enough demand, we may even schedule an online lecture.

Now, to work.

-The [Trail of Bits](https://www.trailofbits.com) Team
