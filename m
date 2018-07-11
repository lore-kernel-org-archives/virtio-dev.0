Return-Path: virtio-dev-return-4672-cohuck=redhat.com@lists.oasis-open.org
Sender: <virtio-dev@lists.oasis-open.org>
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id C61F5985B2A
	for <virtio-dev@lists.oasis-open.org>; Wed, 11 Jul 2018 00:07:39 +0000 (UTC)
MIME-Version: 1.0
In-Reply-To: <20180710045101-mutt-send-email-mst@kernel.org>
References: <20180629221907.3662-1-venu.busireddy@oracle.com>
 <20180702161404.GA2339@rkaganb.sw.ru> <449f1449-ddf6-cd95-976c-14d04d8d503a@oracle.com>
 <20180703095825.GC30904@rkaganb.sw.ru> <d5db37d0-5eaf-8942-8ab7-d73057a67e6f@oracle.com>
 <20180709130035.GA6271@rkaganb.sw.ru> <9136094e-a510-4201-7c71-d1c49226fa5f@oracle.com>
 <20180710045101-mutt-send-email-mst@kernel.org>
From: Siwei Liu <loseweigh@gmail.com>
Date: Tue, 10 Jul 2018 17:07:37 -0700
Message-ID: <CADGSJ20H1S88S6AsYoLMns3XH+YVKh006Dqu808X7Ug+2Mgdnw@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [virtio-dev] Re: [Qemu-devel] [PATCH v3 0/3] Use of unique
 identifier for pairing virtio and passthrough devices...
To: "Michael S. Tsirkin" <mst@redhat.com>
Cc: si-wei liu <si-wei.liu@oracle.com>, Roman Kagan <rkagan@virtuozzo.com>, Venu Busireddy <venu.busireddy@oracle.com>, Marcel Apfelbaum <marcel@redhat.com>, virtio-dev@lists.oasis-open.org, qemu-devel@nongnu.org, "Samudrala, Sridhar" <sridhar.samudrala@intel.com>, Alexander Duyck <alexander.h.duyck@intel.com>, Netdev <netdev@vger.kernel.org>
List-ID: <virtio-dev.lists.oasis-open.org>

On Mon, Jul 9, 2018 at 6:54 PM, Michael S. Tsirkin <mst@redhat.com> wrote:
> On Mon, Jul 09, 2018 at 06:11:53PM -0700, si-wei liu wrote:
>> The plan is to enable group ID based matching in the first place rather than
>> match by MAC, the latter of which is fragile and problematic.
>
> It isn't all that fragile - hyperv used same for a while, so if someone
> posts working patches with QEMU support but before this grouping stuff,
> I'll happily apply them.

I wouldn't box the solution to very limited scenario just because of
matching by MAC, the benefit of having generic group ID in the first
place is that we save the effort of maintaining legacy MAC based
pairing that just adds complexity anyway. Currently the VF's MAC
address cannot be changed by either PF or by the guest user is a
severe limitation due to this. The other use case is that PT device
than VF would generally have different MAC than the standby virtio. We
shouldn't limit itself to VF specific scenario from the very
beginning.

It's just small piece of QEMU code to add in, why not?

>
>> I have made
>> the Linux side changes and will get it posted once the QEMU discussion for
>> grouping is finalized.
>
> Go ahead but at this point I think we need to see actual QEMU support at
> least for the basic functionality before we merge more code Linux-side.

The VFIO visibility work is being worked on. We'll post patches when it's ready.

Thanks,
-Siwei


>
> --
> MST
>
> ---------------------------------------------------------------------
> To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
> For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org
>

---------------------------------------------------------------------
To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org

