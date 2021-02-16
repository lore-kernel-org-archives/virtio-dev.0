Return-Path: virtio-comment-return-1723-cohuck=redhat.com@lists.oasis-open.org
Sender: <virtio-comment@lists.oasis-open.org>
List-Post: <mailto:virtio-comment@lists.oasis-open.org>
List-Help: <mailto:virtio-comment-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-comment-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-comment-subscribe@lists.oasis-open.org>
References: <20210212095920.249768-1-peter.hilber@opensynergy.com>
 <20210216161208.GA1463@shell.armlinux.org.uk>
 <DBBPR08MB4790802EA436661E4AEEEFF682879@DBBPR08MB4790.eurprd08.prod.outlook.com>
 <20210216165705.GB1463@shell.armlinux.org.uk>
 <DBBPR08MB4790C18DDCA35B7C33D43CF782879@DBBPR08MB4790.eurprd08.prod.outlook.com>
From: Peter Hilber <peter.hilber@opensynergy.com>
Message-ID: <3feccb6f-1789-4cd8-b18f-748464539a50@opensynergy.com>
Date: Tue, 16 Feb 2021 20:26:51 +0100
MIME-Version: 1.0
In-Reply-To: <DBBPR08MB4790C18DDCA35B7C33D43CF782879@DBBPR08MB4790.eurprd08.prod.outlook.com>
Subject: [virtio-comment] Re: [PATCH v6] Add virtio SCMI device specification
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
To: Souvik Chakravarty <Souvik.Chakravarty@arm.com>, Russell King - ARM Linux admin <linux@armlinux.org.uk>
Cc: "virtio-dev@lists.oasis-open.org" <virtio-dev@lists.oasis-open.org>, "jean-philippe@linaro.org" <jean-philippe@linaro.org>, Sudeep Holla <Sudeep.Holla@arm.com>, Peter Hilber <peter.hilber@opensynergy.com>, Cristian Marussi <Cristian.Marussi@arm.com>, "virtio-comment@lists.oasis-open.org" <virtio-comment@lists.oasis-open.org>, "alex.bennee@linaro.org" <alex.bennee@linaro.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>
List-ID: <virtio-dev.lists.oasis-open.org>

On 16.02.21 18:31, Souvik Chakravarty wrote:
>> From: Russell King - ARM Linux admin <linux@armlinux.org.uk>
>> Sent: Tuesday, February 16, 2021 4:57 PM
>>
>> On Tue, Feb 16, 2021 at 04:48:30PM +0000, Souvik Chakravarty wrote:
>>>> From: Russell King - ARM Linux admin <linux@armlinux.org.uk>
>>>> Sent: Tuesday, February 16, 2021 4:12 PM I'm not too familiar with
>>>> SCMI, but I think this question is worth asking...
>>>>
>>>> If the SCMI protocol can be used to control system level power
>>>> management, and if the intention is to expose this firmware
>>>> interface to virtualised guests, what prevents a guest from
>>>> controlling the power settings for stuff it should not have access to?
>>>>
>>>> For example, if it's possible to tell the system to power down a
>>>> critical host component through SCMI, what would prevent a guest
>>>> requesting that critical component from having its power cut?
>>>
>>> Short summary:
>>> SCMI as a protocol has built in requirements where only the resources
>>> (specific clock, sensor etc.) which are specifically needed by a VM
>>> are exposed to it. Resources are mapped by Identifiers and if the VM
>>> tries to access an identifier which it does not have access to, the
>>> SCMI backend can simply ignore or return DENIED. At no point is direct
>> access to any power mgmt. hardware granted to any VM, nor is a VM
>> supposed to have global access to all system resources.
>>> There is always a firmware backend which controls the hardware and
>>> services SCMI command requests from agents/guests, after due validation.
>>> The SCMI device/firmware which implements the SCMI backend, is
>>> responsible for implementing these resource isolation guarantees.
>>
>> You seem to be saying the SCMI firmware itself is responsible for
>> implementing this. Given what I've seen from vendors in ATF, this does not
>> leave me with much confidence that there will be sufficient security. It
>> concerns me more when you say that the "backend" is responsible for
>> making these decisions. This doesn't sound good to me.
> 
> [Somehow realizing I cannot post to virtio-dev...]
> Let me try to add a bit of color because I realize I did mix up a few usage models 
> (baremetal & virtualized) in my previous reply. 
> 
> Let me rephrase from the perspective of a virtualized system using Virtio SCMI specifically. 
> In this specific case, the commands issued by the VM will go to the SCMI virtio backend
> which is in the host. This can then choose can choose to reject VM issued SCMI commands.
> 

In my company's implementation, the integrator has to explicitly list
every resource which the "firmware" should make available to the
virtualization guest. As Souvik wrote, the "firmware" is in fact a
dedicated virtualization component, which was designed with security in
mind. I hope hearing this lessens your concerns.


This publicly archived list offers a means to provide input to the
OASIS Virtual I/O Device (VIRTIO) TC.

In order to verify user consent to the Feedback License terms and
to minimize spam in the list archive, subscription is required
before posting.

Subscribe: virtio-comment-subscribe@lists.oasis-open.org
Unsubscribe: virtio-comment-unsubscribe@lists.oasis-open.org
List help: virtio-comment-help@lists.oasis-open.org
List archive: https://lists.oasis-open.org/archives/virtio-comment/
Feedback License: https://www.oasis-open.org/who/ipr/feedback_license.pdf
List Guidelines: https://www.oasis-open.org/policies-guidelines/mailing-lists
Committee: https://www.oasis-open.org/committees/virtio/
Join OASIS: https://www.oasis-open.org/join/

