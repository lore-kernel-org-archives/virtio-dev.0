Return-Path: <virtio-dev-return-8396-cohuck=redhat.com@lists.oasis-open.org>
Sender: <virtio-dev@lists.oasis-open.org>
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id 8BDF2985EAD
	for <virtio-dev@lists.oasis-open.org>; Mon, 26 Jul 2021 14:13:59 +0000 (UTC)
From: Cornelia Huck <cohuck@redhat.com>
In-Reply-To: <20210726091723-mutt-send-email-mst@kernel.org>
References: <BY5PR02MB707313DCD9C7D356D79C8F07F9E59@BY5PR02MB7073.namprd02.prod.outlook.com>
 <87h7gh5od5.fsf@redhat.com>
 <20210726091723-mutt-send-email-mst@kernel.org>
Date: Mon, 26 Jul 2021 16:13:49 +0200
Message-ID: <878s1t5fj6.fsf@redhat.com>
MIME-Version: 1.0
Subject: [virtio-dev] Re: [PATCH v1] virtio-mmio: Specify wait needed in driver during reset
Content-Type: text/plain
To: "Michael S. Tsirkin" <mst@redhat.com>
Cc: Srivatsa Vaddagiri <svaddagi@qti.qualcomm.com>, "jasowang@redhat.com" <jasowang@redhat.com>, "virtio-dev@lists.oasis-open.org" <virtio-dev@lists.oasis-open.org>, Trilok Soni <tsoni@quicinc.com>, Pratik Patel <pratikp@quicinc.com>
List-ID: <virtio-dev.lists.oasis-open.org>

On Mon, Jul 26 2021, "Michael S. Tsirkin" <mst@redhat.com> wrote:

> On Mon, Jul 26, 2021 at 01:03:02PM +0200, Cornelia Huck wrote:
>> On Fri, Jul 23 2021, Srivatsa Vaddagiri <svaddagi@qti.qualcomm.com> wrote:
>> > Reset of a virtio-mmio device is accomplished by writing 0 to its Status register.
>> > For devices that are emulated in software, writes to Status register are trapped
>> > and resumed only after the reset operation is complete. Thus a driver can be
>> > assured of reset completion as soon as its write completes.
>> >
>> > That may not be the case for virtio-mmio devices implemented in hardware
>> > directly. A write could complete before the reset operation inside device is
>> > completed. Introduce a new feature, VIRTIO_F_MMIO_RESET_WAIT, that such devices
>> > will offer as means to indicate to driver that they need to poll for reset
>> > completion, indicated by a read of Status register returning 0.
>> >
>> > Signed-off-by: Srivatsa Vaddagiri <svaddagi@qti.qualcomm.com>
>> >
>> > diff --git a/content.tex b/content.tex
>> > index 5c70a3c..1990a5c 100644
>> > --- a/content.tex
>> > +++ b/content.tex
>> > @@ -1924,7 +1924,10 @@ \subsection{MMIO Device Register Layout}\label{sec:Virtio Transport Options / Vi
>> >  do not represent events which took place MUST be zero.
>> >
>> >  Upon reset, the device MUST clear all bits in \field{InterruptStatus} and ready bits in the
>> > -\field{QueueReady} register for all queues in the device.
>> > +\field{QueueReady} register for all queues in the device. The device MUST also offer
>> > +VIRTIO_F_MMIO_RESET_WAIT if it requires driver to poll for reset completion
>> 
>> s/driver/the driver/
>> 
>> > +indicated by a read of \field{Status} returning 0. Such a device MUST also fail to accept
>> > +FEATURES_OK bit if driver does not negotiate VIRTIO_F_MMIO_RESET_WAIT.
>> 
>> So, this basically means that an older driver that does not know the new
>> feature bit will not work with devices offering this bit, even if it did
>> poll? This seems acceptable, I just wanted to spell it out.
>
> Maybe should or even may is enough here. For example it is reasonable to have
> hypervisor block guest until reset is complete.

Maybe MAY reject, and SHOULD if there's no mitigating mechnism
available?


---------------------------------------------------------------------
To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org

