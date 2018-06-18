Return-Path: virtio-dev-return-4417-cohuck=redhat.com@lists.oasis-open.org
Sender: <virtio-dev@lists.oasis-open.org>
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [66.179.20.138])
	by lists.oasis-open.org (Postfix) with ESMTP id E32975818F13
	for <virtio-dev@lists.oasis-open.org>; Mon, 18 Jun 2018 08:08:51 -0700 (PDT)
References: <20180611075640.19751-1-tiwei.bie@intel.com>
 <2eb17c91-9158-c14f-e582-223dd6e5c6d2@linux.ibm.com>
 <20180615151329-mutt-send-email-mst@kernel.org>
 <545e8649-8029-d135-e927-3ad11f4eb29d@linux.ibm.com>
 <20180615154837-mutt-send-email-mst@kernel.org>
 <cf3ea375-5b01-0222-166d-7ec837ffc205@linux.ibm.com>
 <20180615183657-mutt-send-email-mst@kernel.org>
From: Halil Pasic <pasic@linux.ibm.com>
Date: Mon, 18 Jun 2018 17:08:32 +0200
MIME-Version: 1.0
In-Reply-To: <20180615183657-mutt-send-email-mst@kernel.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Message-Id: <f5d6d437-44a1-3421-cbad-10281c446b56@linux.ibm.com>
Subject: Re: [virtio-dev] [PATCH v3] content: enhance device requirements for
 feature bits
To: "Michael S. Tsirkin" <mst@redhat.com>
Cc: Tiwei Bie <tiwei.bie@intel.com>, cohuck@redhat.com, stefanha@redhat.com, pbonzini@redhat.com, virtio-dev@lists.oasis-open.org, dan.daly@intel.com, cunming.liang@intel.com, zhihong.wang@intel.com
List-ID: <virtio-dev.lists.oasis-open.org>



On 06/15/2018 05:37 PM, Michael S. Tsirkin wrote:
> On Fri, Jun 15, 2018 at 05:16:10PM +0200, Halil Pasic wrote:
>>
>>
>> On 06/15/2018 03:38 PM, Michael S. Tsirkin wrote:
>>> On Fri, Jun 15, 2018 at 02:42:58PM +0200, Halil Pasic wrote:
>>>>
>>>>
>>>> On 06/15/2018 02:19 PM, Michael S. Tsirkin wrote:
>>>>> On Fri, Jun 15, 2018 at 02:10:11PM +0200, Halil Pasic wrote:
>>>>>>
>>>>>>
>>>>>> On 06/11/2018 09:56 AM, Tiwei Bie wrote:
>>>>>>> Suggested-by: Michael S. Tsirkin <mst@redhat.com>
>>>>>>> Signed-off-by: Tiwei Bie <tiwei.bie@intel.com>
>>>>>>> Fixes: https://github.com/oasis-tcs/virtio-spec/issues/14
>>>>>>> ---
>>>>>>> v2:
>>>>>>> - Refine the wording (Cornelia);
>>>>>>>
>>>>>>> v3:
>>>>>>> - Refine the wording (MST);
>>>>>>>
>>>>>>>      content.tex | 7 +++++++
>>>>>>>      1 file changed, 7 insertions(+)
>>>>>>>
>>>>>>> diff --git a/content.tex b/content.tex
>>>>>>> index f996fad..3c7d67d 100644
>>>>>>> --- a/content.tex
>>>>>>> +++ b/content.tex
>>>>>>> @@ -125,6 +125,13 @@ which was not offered.  The device SHOULD accept any valid subset
>>>>>>>      of features the driver accepts, otherwise it MUST fail to set the
>>>>>>>      FEATURES_OK \field{device status} bit when the driver writes it.
>>>>>>> +If a device has successfully negotiated a set of features
>>>>>>> +at least once (by accepting the FEATURES_OK \field{device
>>>>>>> +status} bit during device initialization), then it SHOULD
>>>>>>> +NOT fail re-negotiation of the same set of features after
>>>>>>> +a device or system reset.  Failure to do so would interfere
>>>>>>> +with resuming from suspend and error recovery.
>>>>>>> +
>>>>>>
>>>>>>
>>>>>> Sorry people but I don't get it. I mean it is kind of reasonable
>>>>>> to assume that with a given device and a given driver (given, i.e.
>>>>>> nothing changes) the two will always negotiate the same features
>>>>>> (including the extremal case where the negotiation fails).
>>>>>>
>>>>>> Either the device or a driver rolling a dice to make feature negotiation
>>>>>> more fun seems quite unreasonable. So I assume this is not what we are
>>>>>> bothering to soft prohibit here.
>>>>>>
>>>>>> So the interesting scenario seems to be when stuff changes. When
>>>>>> migrating the implementation of the device could change. Or something
>>>>>> changes regarding the resources used to provide the virtual device.
>>>>>>
>>>>>> But then, if the device really can not support the set of features
>>>>>> it used to be able, I guess the SHOULD does not take effect (I guess
>>>>>> that is the difference compared to MUST).
>>>>>>
>>>>>> Bottom line is: I tried to figure out what is this about, but I failed.
>>>>>> I've read https://github.com/oasis-tcs/virtio-spec/issues/14 too but
>>>>>> it did not click. I would appreciate some assistance.
>>>>>
>>>>> It's exactly what it says. Let's say you negotiated a feature and then
>>>>> device sets NEED_RESET.  Driver must now reset the device and put it
>>>>> back in the same state it had before the reset, then resubmit
>>>>> requests that were available but never used.
>>>>>
>>>>> What if any of the features changed? Device suddenly
>>>>> needs to check for requests which do not match the
>>>>> features.
>>>>>
>>>>> Suspend is similar: guests tend to assume hardware does not change
>>>>> across suspend/resume, any changes tend to make resume fail.
>>>>>
>>>>
>>>> Thank you very much! But it still does not answer why would a device
>>>> want to do that (fail to negotiate a feature that it was able to
>>>> negotiate before). So I'm still in the dark about what are we trading
>>>> for what.
>>>
>>> It would be a mis-configured device.  For example QEMU does not migrate
>>> the device features so if you misconfigure QEMU with different flags on
>>> source and destination (not a supported configuration), features might
>>> seem to change from guest POV.
>>>
>>
>> Do you mean set (or rather restrict) what QEMU calls the host_features?
>>
>> AFAIR there is no reset right after the migration. But yes if then there
>> is a reset and another migration. After a lots of thinking, it seems you
>> speak about the scenario I described in the answer to Tiwei Bie. But
>> there I also say that this statement you add here is not good enough for
>> that. Still puzzled.
> 
> What would a good enough statement look like?
> 
> 


I did some reading and some thinking on the weekend. AFAIU the situation
is tricky. To mitigate that let me establish the terminology I'm going to
use. For vm lifecycle I'm going to use the definitions form libvirt as
defined by https://libvirt.org/guide/html/Application_Development_Guide-Guest_Domains-Lifecycle.html.

You explained, the motivation for this addition to the VIRTIO
specification is hibernate (aka suspend to disk).

(1) AFAIU on hibernate the VM goes from 'running' to (most likely)
'defined'.  The first step of the resume from hibernate is to start the
VM. From the guest OS life-cycle perspective however we don't start a
completely new cycle (like the VM life-cycle does) with complete
re-initialization. After resuming form hibernate the system is expected
to be put in essentially the same state (but not exactly) as it was
before hibernate.

(2) From VM (life-cycle) perspective we can not distinguish between a
'shutdown' as a part of a  hibernate and a 'plain shutdown'.

(3) Any rule we come up for a device (e.g. the normative statement
proposed here) that regulates the effects of a 'system reset' that is a
part of the hibernate cycle equally affects the normal shutdown-start
cycle.

(4) Any change in the negotiated feature set can affect the validity of
requests that have been constructed under different assumptions (i.e.
not only features going away, but also features appearing can be a
problem).

(5) The Linux implementation already has reasonable handling for both
types of changes: the driver does not try to use the new features, and
fails cleanly if the old ones are not accepted.

(6) Because of (3), prohibiting devices dropping support for a set of
features within a hibernate cycle is only possible if we prohibit such
changes in general.

(7) If I read
https://www.kernel.org/doc/html/v4.14/driver-api/pm/devices.html
correctly the driver is expected to quiesce the device before going to
hibernate. AFAIU hibernating with requests in flight isn't a great idea.

(8) If there are no in-flight requests in-flight (including on the
queues), then this whole feature changes might break requests story seems
irrelevant.

(9) After a quick look the freeze in virtio (Linux implementation) does
not seem to do anything to prevent in-flight requests though.

(10) From a VM management perspective a 'save' seems much preferable to
hibernate.  A VM 'save' is migration like, so even if some components of
the system change between 'save' and 'restore' (e.g. QEMU up- or
donwngarde) we still have mechanisms in place that (hopefully) the guest
view of the system does not change. In this sense save/restore is
migration like.

(11) The VIRTIO specification is a bit vague about how a reset is
supposed to be handled by the guest, but it certainly does not prohibit
the negotiated features from changing after reset. Here I will quote two
fragments that hint this is actually something foreseen by the VIRTIO
standard:
  * 'During device initialization, the driver reads this and tells the
     device the subset that it accepts.  The only way to renegotiate is to
     reset the device.'
  * 'If the driver sets the FAILED bit, the driver MUST later reset the
     device before attempting to re-initialize.' If re-initialize is in a
     sense of '3.1.1 Driver Requirements: Device Initialization' then full
     feature negotiation seems to be compulsory.  Linux does not do this. But
     since setting up queues seems to be a part of the 3.1.1 initialization
     sequence (even if formulated somewhat vague), my best guess after reset
     the driver is not supposed to perform 3.1.1 to the letter.

(12) If I were to hibernate my PC and then, let's say replace my NIC with
a different model, the hardware does not change assumption would not hold
for a non-virtualized system either. I'm not sure this problem is ours to
solve.

My conclusion is the following. I think constraining feature changes
after system_reset is a bad idea. For 'normal' virtio reset some
clarifications would be welcome, but this one does not seem to be a very
good one. Regarding changing features, I think we are good enough with
what we have today (both standard and implementation). However if we want
to prohibit the features from changing after a reset in spite of my
arguments presented here, IMHO we need a driver normative statement too.

Regards,
Halil


---------------------------------------------------------------------
To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org

