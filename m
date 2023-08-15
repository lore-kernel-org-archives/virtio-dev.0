Return-Path: <virtio-dev-return-13540-virtio-dev=archiver.kernel.org@lists.oasis-open.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from ws5-mx01.kavi.com (ws5-mx01.kavi.com [34.193.7.191])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1A30DC04A6A
	for <virtio-dev@archiver.kernel.org>; Tue, 15 Aug 2023 10:14:41 +0000 (UTC)
Received: from lists.oasis-open.org (oasis.ws5.connectedcommunity.org [10.110.1.242])
	by ws5-mx01.kavi.com (Postfix) with ESMTP id 6D1C8C624F
	for <virtio-dev@archiver.kernel.org>; Tue, 15 Aug 2023 10:14:40 +0000 (UTC)
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id 69EF598638E
	for <virtio-dev@archiver.kernel.org>; Tue, 15 Aug 2023 10:14:40 +0000 (UTC)
Received: from host09.ws5.connectedcommunity.org (host09.ws5.connectedcommunity.org [10.110.1.97])
	by lists.oasis-open.org (Postfix) with QMQP
	id 5D19A98634B; Tue, 15 Aug 2023 10:14:40 +0000 (UTC)
Mailing-List: contact virtio-dev-help@lists.oasis-open.org; run by ezmlm
List-ID: <virtio-dev.lists.oasis-open.org>
Sender: <virtio-dev@lists.oasis-open.org>
Precedence: bulk
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id 4ADB098633F;
	Tue, 15 Aug 2023 10:14:38 +0000 (UTC)
X-Virus-Scanned: amavisd-new at kavi.com
X-IronPort-AV: E=McAfee;i="6600,9927,10802"; a="403227891"
X-IronPort-AV: E=Sophos;i="6.01,174,1684825200"; 
   d="scan'208";a="403227891"
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.01,202,1684825200"; 
   d="scan'208";a="877299752"
Message-ID: <f1557a4d-537d-a497-a586-6bc8e1d6f64d@intel.com>
Date: Tue, 15 Aug 2023 18:14:31 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Firefox/102.0 Thunderbird/102.14.0
Content-Language: en-US
To: Jason Wang <jasowang@redhat.com>, Stefan Hajnoczi <stefanha@redhat.com>
Cc: mst@redhat.com, eperezma@redhat.com, cohuck@redhat.com,
 virtio-comment@lists.oasis-open.org, virtio-dev@lists.oasis-open.org
References: <20230814192904.30062-1-lingshan.zhu@intel.com>
 <20230814154717.GI3146793@fedora>
 <CACGkMEs=bM_M42q1wThxg8LV_+kYiO_-EC3Os7oUp5uJa9jFcw@mail.gmail.com>
From: "Zhu, Lingshan" <lingshan.zhu@intel.com>
In-Reply-To: <CACGkMEs=bM_M42q1wThxg8LV_+kYiO_-EC3Os7oUp5uJa9jFcw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Subject: [virtio-dev] Re: [virtio-comment] [RFC PATCH 0/5] virtio: introduce SUSPEND bit
 and vq state



On 8/15/2023 9:38 AM, Jason Wang wrote:
> On Tue, Aug 15, 2023 at 12:28 AM Stefan Hajnoczi <stefanha@redhat.com> wrote:
>> On Tue, Aug 15, 2023 at 03:28:59AM +0800, Zhu Lingshan wrote:
>>> This seires introduces
>>> 1)a new SUSPEND bit in the device status
>>> Which is used to suspend the device, so that the device states
>>> and virtqueue states are stablized.
>>>
>>> 2)virtqueue state and accessors, to get and set last_avail_idx
>>> and last_used_idx of virtqueues.
>>>
>>> The main usecase of these new facilities is Live Migration.
>>>
>>> Furture work: dirty page tracking and in-flight descriptors.
>>>
>>> This is RFC, this series carries on Jason and Eugenio's pervious work.
>>>
>>> Any comments are welcome.
>> In order to support stateful devices like virtiofs, virtio-gpu, or
>> virtio-crypto it would be necessary to add device state save/load
>> functionality too.
> +1 and before save/load, we need to define those states first.
>
> E.g there are patches that try to fix the GPU suspend/hibernation
> which probably requires those facilities as well.
I agree, we should define the states of the device types first, like
virtio-fs. For virtio-net, one of the states if in-flight descriptors,
and this is planned work.

>
>> Even virtio-net needs device state save/load functionality if the VMM is
>> not intercepting the stateful controlq.
> Yes, this could be done via trap and emulation.
I agree
>
>> In-flight descriptors can be included in the device state.
>>
> Probably.
Yes, in-flight descriptors and dirty page tracking are in the plan. This 
series only
implements SUSPEND and vq state accessors as the first RFC try to 
collect comments.
>
>> In fact, the only reason why I think VIRTIO_F_QUEUE_STATE makes sense is
>> for easy integration into existing vhost software stacks. Otherwise we
>> should just define a device state save/load interface along with
>> standard device state serialization for devices where migration
>> interoperability is possible. VIRTIO_F_QUEUE_STATE is a small subset of
>> device state save/load.
> For simple devices like virtio-net, queue state should be sufficient
> for hardware.
>
>> I think the convenience of integrating into existing vhost software
>> stacks is worth the duplication, but I wanted to mention that this
>> interface will not be enough to live migrate all device types and we'll
>> need something more in the future.
> Yes, the patch is a start for simple stateless devices.
Yes!

Thanks!
>
> Thanks
>
>> Stefan
>>
>>> Zhu Lingshan (5):
>>>    virtio: introduce SUSPEND bit in device status
>>>    virtio: introduce vq state as basic facility
>>>    virtio: The actions by the device upon SUSPEND
>>>    virtqueue: constraints for virtqueue state
>>>    virtio-pci: implement VIRTIO_F_QUEUE_STATE
>>>
>>>   content.tex       | 120 ++++++++++++++++++++++++++++++++++++++++++++++
>>>   transport-pci.tex |  15 ++++++
>>>   2 files changed, 135 insertions(+)
>>>
>>> --
>>> 2.35.3
>>>
>>>
>>> This publicly archived list offers a means to provide input to the
>>> OASIS Virtual I/O Device (VIRTIO) TC.
>>>
>>> In order to verify user consent to the Feedback License terms and
>>> to minimize spam in the list archive, subscription is required
>>> before posting.
>>>
>>> Subscribe: virtio-comment-subscribe@lists.oasis-open.org
>>> Unsubscribe: virtio-comment-unsubscribe@lists.oasis-open.org
>>> List help: virtio-comment-help@lists.oasis-open.org
>>> List archive: https://lists.oasis-open.org/archives/virtio-comment/
>>> Feedback License: https://www.oasis-open.org/who/ipr/feedback_license.pdf
>>> List Guidelines: https://www.oasis-open.org/policies-guidelines/mailing-lists
>>> Committee: https://www.oasis-open.org/committees/virtio/
>>> Join OASIS: https://www.oasis-open.org/join/
>>>


---------------------------------------------------------------------
To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org

