Return-Path: <virtio-dev-return-12719-virtio-dev=archiver.kernel.org@lists.oasis-open.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from ws5-mx01.kavi.com (ws5-mx01.kavi.com [34.193.7.191])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 192D5C7EE2D
	for <virtio-dev@archiver.kernel.org>; Tue, 16 May 2023 11:47:37 +0000 (UTC)
Received: from lists.oasis-open.org (oasis.ws5.connectedcommunity.org [10.110.1.242])
	by ws5-mx01.kavi.com (Postfix) with ESMTP id 2E55B71C8E
	for <virtio-dev@archiver.kernel.org>; Tue, 16 May 2023 11:47:37 +0000 (UTC)
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id 0551D9865A6
	for <virtio-dev@archiver.kernel.org>; Tue, 16 May 2023 11:47:37 +0000 (UTC)
Received: from host09.ws5.connectedcommunity.org (host09.ws5.connectedcommunity.org [10.110.1.97])
	by lists.oasis-open.org (Postfix) with QMQP
	id DF045983E4A; Tue, 16 May 2023 11:47:36 +0000 (UTC)
Mailing-List: contact virtio-dev-help@lists.oasis-open.org; run by ezmlm
List-ID: <virtio-dev.lists.oasis-open.org>
Sender: <virtio-dev@lists.oasis-open.org>
Precedence: bulk
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id CC631986510
	for <virtio-dev@lists.oasis-open.org>; Tue, 16 May 2023 11:47:36 +0000 (UTC)
X-Virus-Scanned: amavisd-new at kavi.com
X-MC-Unique: lkdu9_crOhOaeXxaK_Hrcg-1
From: Cornelia Huck <cohuck@redhat.com>
To: "Michael S. Tsirkin" <mst@redhat.com>
Cc: Parav Pandit <parav@nvidia.com>, virtio-comment@lists.oasis-open.org,
 virtio-dev@lists.oasis-open.org, shahafs@nvidia.com
In-Reply-To: <20230516054313-mutt-send-email-mst@kernel.org>
Organization: Red Hat GmbH
References: <20230516030139.767838-1-parav@nvidia.com>
 <20230516013842-mutt-send-email-mst@kernel.org>
 <87lehohefn.fsf@redhat.com>
 <20230516054313-mutt-send-email-mst@kernel.org>
User-Agent: Notmuch/0.37 (https://notmuchmail.org)
Date: Tue, 16 May 2023 13:47:32 +0200
Message-ID: <87fs7wh50r.fsf@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.6
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain
Subject: [virtio-dev] Re: [PATCH] content: Replace guest OS with driver

On Tue, May 16 2023, "Michael S. Tsirkin" <mst@redhat.com> wrote:

> On Tue, May 16, 2023 at 10:24:12AM +0200, Cornelia Huck wrote:
>> On Tue, May 16 2023, "Michael S. Tsirkin" <mst@redhat.com> wrote:
>> 
>> > On Tue, May 16, 2023 at 06:01:39AM +0300, Parav Pandit wrote:
>> >> diff --git a/content.tex b/content.tex
>> >> index 9df81b8..417d476 100644
>> >> --- a/content.tex
>> >> +++ b/content.tex
>> >> @@ -26,10 +26,10 @@ \section{\field{Device Status} Field}\label{sec:Basic Facilities of a Virtio Dev
>> >>  following bits are defined (listed below in the order in which
>> >>  they would be typically set):
>> >>  \begin{description}
>> >> -\item[ACKNOWLEDGE (1)] Indicates that the guest OS has found the
>> >> +\item[ACKNOWLEDGE (1)] Indicates that the driver has found the
>> >>    device and recognized it as a valid virtio device.
>> >>  
>> >> -\item[DRIVER (2)] Indicates that the guest OS knows how to drive the
>> >> +\item[DRIVER (2)] Indicates that the driver knows how to drive the
>> >>    device.
>> >>    \begin{note}
>> >>      There could be a significant (or infinite) delay before setting
>> >
>> > Actually, there is a subtle difference here that this is losing.
>> > "guest OS" really refers to e.g. Linux virtio core code here.
>> >
>> >
>> > ACKNOWLEDGE and DRIVER are used by virtio core.
>> >
>> > ACKNOWLEDGE tells you virtio core attached to device, and DRIVER
>> > tells you core found a device specific driver.
>> >
>> >
>> >
>> > If you really want to make things better, let's find a way to explain
>> > all this.
>> 
>> Agreed, this is a really old part of the spec, and likely had been
>> written with the Linux device probing sequence in mind.
>> 
>> Basically, we want to distinguish between "something on the driver side
>> has discovered the device" and "something on the driver side knows how
>> to drive this specific device". If we consider "driver" as a catch-all
>> of the whole thing talking to a device, we need to be extra descriptive
>> (and we can add examples, as this is a non-normative section.)
>> 
>> For ACKNOWLEDGE, maybe "indicates that the driver has discovered the
>> device and recognized it as a valid virtio device" (i.e. mostly what we
>> have now), but also add "For example, this can indicate that non-device
>> specific virtio driver code has attached to the device."
>> 
>> For DRIVER, maybe "indicates that the driver has discovered that it
>> knows how to drive this device specifically. For example, this can
>> indicate that device-specific driver code has attached to the device."
>
>
> I feel examples are a weak way to document it - if we can not say
> what this is specifically, what purpose does it serve?

Not really documenting, but rather illustrating it.

> Actually, we do have a distinction, between transport and device type.
> Can't we use that? It seems more consistent than "non-device
> specific" and "device specific".

What do we consider to be the "transport"? {pci,mmio,ccw} + virtio ring,
or only {pci,mmio,ccw}? This might be confusiong, since at least in the
Linux case, it is the virtio ring/generic code that sets ACKNOWLEDGE,
while the pci/mmio/ccw code is not fiddling with the status at that
stage.

> SO I propose:
>
> \item[ACKNOWLEDGE (1)] Indicates that a transport driver has found the
>     device and recognized it as a valid virtio device transport.

What is a "virtio device transport"?

>   
> \item[DRIVER (2)] Indicates that a device type specific driver was found
>     and will attempt to attach to the device.
>
>
>
> BTW somewhat related, I would maybe fix
> device-types/mem/description.tex:change
> not to say "device driver", just "driver" for brevity.

That one makes sense to me.


---------------------------------------------------------------------
To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org

