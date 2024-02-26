Return-Path: <virtio-dev-return-14354-virtio-dev=archiver.kernel.org@lists.oasis-open.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from ws5-mx01.kavi.com (ws5-mx01.kavi.com [34.193.7.191])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6DE46C54E49
	for <virtio-dev@archiver.kernel.org>; Mon, 26 Feb 2024 10:23:58 +0000 (UTC)
Received: from lists.oasis-open.org (oasis.ws5.connectedcommunity.org [10.110.1.242])
	by ws5-mx01.kavi.com (Postfix) with ESMTP id C5EA62ACB0
	for <virtio-dev@archiver.kernel.org>; Mon, 26 Feb 2024 10:23:57 +0000 (UTC)
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id B97BC986512
	for <virtio-dev@archiver.kernel.org>; Mon, 26 Feb 2024 10:23:57 +0000 (UTC)
Received: from host09.ws5.connectedcommunity.org (host09.ws5.connectedcommunity.org [10.110.1.97])
	by lists.oasis-open.org (Postfix) with QMQP
	id ACBD7986364; Mon, 26 Feb 2024 10:23:57 +0000 (UTC)
Mailing-List: contact virtio-dev-help@lists.oasis-open.org; run by ezmlm
List-ID: <virtio-dev.lists.oasis-open.org>
Sender: <virtio-dev@lists.oasis-open.org>
Precedence: bulk
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id 9B27A986339
	for <virtio-dev@lists.oasis-open.org>; Mon, 26 Feb 2024 10:23:54 +0000 (UTC)
X-Virus-Scanned: amavisd-new at kavi.com
X-IronPort-AV: E=McAfee;i="6600,9927,10995"; a="3089110"
X-IronPort-AV: E=Sophos;i="6.06,185,1705392000"; 
   d="scan'208";a="3089110"
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.06,185,1705392000"; 
   d="scan'208";a="7143177"
Message-ID: <745ecbc9-00e2-4330-877e-a7b2104212fb@intel.com>
Date: Mon, 26 Feb 2024 18:23:46 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Content-Language: en-US
To: David Stevens <stevensd@chromium.org>, Jason Wang <jasowang@redhat.com>
Cc: "Michael S . Tsirkin" <mst@redhat.com>,
 virtio-comment@lists.oasis-open.org, virtio-dev@lists.oasis-open.org,
 parav@nvidia.com
References: <20240216082432.709956-1-stevensd@chromium.org>
 <20240216082432.709956-2-stevensd@chromium.org>
 <CACGkMEuP=ZcbRf4G8O1hBjg0s5uNbrRMO=ESnU0AKWSHmF_fMQ@mail.gmail.com>
 <CAD=HUj5-N=rra9BBbNgV3uAtGGwAmK6sRhA6eNaG5O5L95KPag@mail.gmail.com>
From: "Zhu, Lingshan" <lingshan.zhu@intel.com>
In-Reply-To: <CAD=HUj5-N=rra9BBbNgV3uAtGGwAmK6sRhA6eNaG5O5L95KPag@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Subject: [virtio-dev] Re: [virtio-comment] Re: [PATCH v4 1/1] Add suspend support for
 virtio PCI devices



On 2/26/2024 4:46 PM, David Stevens wrote:
> On Mon, Feb 26, 2024 at 3:42 PM Jason Wang <jasowang@redhat.com> wrote:
>> On Fri, Feb 16, 2024 at 4:25 PM David Stevens <stevensd@chromium.org> wrote:
>>> Add a virtio power management PCI capability to allow drivers to suspend
>>> virtio PCI devices. This allows drivers to suspend devices at the virtio
>>> level before suspending them at the PCI transport layer. This allows
>>> drivers to do a two phase suspend, which prevents notifications from
>>> being ignored or lost if interrupts are reconfigured at the PCI
>>> transport layer immediately before or after the device is put into the
>>> PCI PM D3 low power state.
>>> ---
>>>   transport-pci.tex | 51 +++++++++++++++++++++++++++++++++++++++++++++++
>>>   1 file changed, 51 insertions(+)
>>>
>> I would like to know how the two phase suspend can prevent the loss of
>> notification or interrupt. Or for example, if it can be workaround at
>> the driver level.
> I'll preface this by saying I am not an expert in how Linux handles
> interrupts or in PCI, so I might be missing some important
> information.
>
> Actually, after thinking about this some more, I'm not sure that the
> two phase suspend is necessary per-se. Rather, I think relying only on
> PCI power management is simply insufficient.
>
> According to the kernel's system suspend and device interrupts
> documentation [1], "... after the 'late' phase of device suspend there
> is no legitimate reason why any interrupts from suspended devices
> should trigger and if any devices have not been suspended properly
> yet, it is better to block interrupts from them anyway." PCI power
> management doesn't occur until the noirq phase of suspend, so that's
> too late to be useful here. Other than that, as of right now, there's
> nothing the driver can do to tell devices they need to stop sending
> interrupts. Adding suspend support to the virtio spec would address
> this deficiency.
I think the SUSPEND bit which is a virtio level suspending can help here.
>
> More concretely, I ran into two problems when trying to get shallow
> suspend working with only PCI power management. If there are
> workarounds for this at the driver level, then that would be great.
> But I can't think of any, at least.
>
> First, there is a window between when Linux suspends interrupts with
> suspend_device_irqs and when PCI power management occurs. If the
> device triggers an interrupt in that window, then it won't be lost
> since IRQS_PENDING gets added to the descriptor state. However, if the
> originating event should have woken the guest up from sleep, then that
> doesn't happen, since there is no way for the device to know it
> actually needed to generate a PCI PME. I might be missing something,
> but this seems like something that can't be worked around at the
> driver level.
>
> Second, the core interrupt code can migrate interrupts when CPUs are
> offline'ed entering shallow suspend. Since PCI devices are already in
> D3 at this point, __pci_write_msi_msg does not update the MSI routing.
> When bringing the device back up, there is a window between when the
> device is put into D0 and when the updated routing tables are written
> by __pci_restore_msix_state. If the device sends an interrupt in this
> window, then it will be sent to the completely wrong handler in the
> guest (or dropped if there is no handler installed). I guess this
> could be worked around in the core PCI code by masking MSIX interrupts
> before suspending the device. However, the fact that Linux doesn't
> already do that today suggests that we're wrong, rather than everybody
> else happens to be wrong in just the right way.
I am not a PCI expert, please correct me if I misunderstand anything.

MSI interrupt are in-band DMA writing, so the data is always secure,
and CPU should process them anyway even after waking up, the handler is
always there since the driver register it.

The device should not send any interrupts(both vq and config) once it
presents SUSPEND.

For PM, I think we should not SUSPEND a PCI device by PM,
PM should be supplementary steps for SUSPENDING.

While we are working on this patch, I will address the comments for
the SUSPENDING bit patch and work our a V2 to wider review and more
comments. Finally we will merge into a series.

Thanks
>
> [1] https://www.kernel.org/doc/Documentation/power/suspend-and-interrupts.rst
>
> -David
>
> This publicly archived list offers a means to provide input to the
>
> OASIS Virtual I/O Device (VIRTIO) TC.
>
>
>
> In order to verify user consent to the Feedback License terms and
>
> to minimize spam in the list archive, subscription is required
>
> before posting.
>
>
>
> Subscribe: virtio-comment-subscribe@lists.oasis-open.org
>
> Unsubscribe: virtio-comment-unsubscribe@lists.oasis-open.org
>
> List help: virtio-comment-help@lists.oasis-open.org
>
> List archive: https://lists.oasis-open.org/archives/virtio-comment/
>
> Feedback License: https://www.oasis-open.org/who/ipr/feedback_license.pdf
>
> List Guidelines: https://www.oasis-open.org/policies-guidelines/mailing-lists
>
> Committee: https://www.oasis-open.org/committees/virtio/
>
> Join OASIS: https://www.oasis-open.org/join/
>


---------------------------------------------------------------------
To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org

