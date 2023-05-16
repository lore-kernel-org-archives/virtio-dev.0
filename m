Return-Path: <virtio-dev-return-12728-virtio-dev=archiver.kernel.org@lists.oasis-open.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from ws5-mx01.kavi.com (ws5-mx01.kavi.com [34.193.7.191])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DD0DCC7EE23
	for <virtio-dev@archiver.kernel.org>; Tue, 16 May 2023 20:42:45 +0000 (UTC)
Received: from lists.oasis-open.org (oasis.ws5.connectedcommunity.org [10.110.1.242])
	by ws5-mx01.kavi.com (Postfix) with ESMTP id D9F23C6381
	for <virtio-dev@archiver.kernel.org>; Tue, 16 May 2023 20:42:43 +0000 (UTC)
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id D07799865B5
	for <virtio-dev@archiver.kernel.org>; Tue, 16 May 2023 20:42:43 +0000 (UTC)
Received: from host09.ws5.connectedcommunity.org (host09.ws5.connectedcommunity.org [10.110.1.97])
	by lists.oasis-open.org (Postfix) with QMQP
	id C07A79862F6; Tue, 16 May 2023 20:42:43 +0000 (UTC)
Mailing-List: contact virtio-dev-help@lists.oasis-open.org; run by ezmlm
List-ID: <virtio-dev.lists.oasis-open.org>
Sender: <virtio-dev@lists.oasis-open.org>
Precedence: bulk
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id AA9C89862F9
	for <virtio-dev@lists.oasis-open.org>; Tue, 16 May 2023 20:42:42 +0000 (UTC)
X-Virus-Scanned: amavisd-new at kavi.com
X-MC-Unique: cLKshY5zM0uXQl6WDZiaIQ-1
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684269759; x=1686861759;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ODyaakw6zAd7bCEwyP7tflA7LSuXdybvG/9VYr94/X4=;
        b=d5tNweXSsfGhfy7KVKdIhdLLt5ETCE8iexlCQXtn4xvaX73cLwWQxL5GJpLav8zT64
         xPKqKmbCF7DsJ5xsH3qyBiLPscDUAS6v45R1vPt621UrLtHmfzOM2NKH8O2WZ7Lxyr+4
         VyQPU4yvzTZeUOZxgVs2PwRJ0HH9VmXIivV4vCrbQr5v2Gw/YcZ59wgcdaSYPBkIvibj
         W7m9DzskgMONBP09up62TaqgOzjDs3VA64RMxjcQTHO/ZVFB0afLOkXvEv3/KNkjNsQi
         SjRMkRxvOvSorGnJlT2scxLubOuhB9D9C44LKsd5MUtQqJWMY0IuFUhYGrriZs8MRcBw
         bpnw==
X-Gm-Message-State: AC+VfDwUzLFdV9eZHBEaPaUYuFQFJAouzu5n5IjtpGW/MaRctvoclcnF
	MDC7pD3ltJLzRpTgYX4GSI7SDmHqC6HFGQctLAWYwwmbETliqNWvfQdS8c90AcoLP4sZ0R0sw+C
	gTbbfsbMr0pp/f5WfI6N2zZnAF/LV
X-Received: by 2002:a7b:cbd7:0:b0:3f4:c28b:ec88 with SMTP id n23-20020a7bcbd7000000b003f4c28bec88mr13453383wmi.41.1684269759130;
        Tue, 16 May 2023 13:42:39 -0700 (PDT)
X-Google-Smtp-Source: ACHHUZ6ZwvV7LVnFrWdCcKkrUICxj03oSG+2RJgy39E/s6Bg6FzdM4VrP04sVAmIJUeL+aP6gtOnrw==
X-Received: by 2002:a7b:cbd7:0:b0:3f4:c28b:ec88 with SMTP id n23-20020a7bcbd7000000b003f4c28bec88mr13453372wmi.41.1684269758788;
        Tue, 16 May 2023 13:42:38 -0700 (PDT)
Date: Tue, 16 May 2023 16:42:34 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Parav Pandit <parav@nvidia.com>
Cc: "virtio-dev@lists.oasis-open.org" <virtio-dev@lists.oasis-open.org>,
	"cohuck@redhat.com" <cohuck@redhat.com>,
	"david.edmondson@oracle.com" <david.edmondson@oracle.com>,
	"sburla@marvell.com" <sburla@marvell.com>,
	"jasowang@redhat.com" <jasowang@redhat.com>,
	Yishai Hadas <yishaih@nvidia.com>, Maor Gottlieb <maorg@nvidia.com>,
	"virtio-comment@lists.oasis-open.org" <virtio-comment@lists.oasis-open.org>,
	Shahaf Shuler <shahafs@nvidia.com>
Message-ID: <20230516162342-mutt-send-email-mst@kernel.org>
References: <20230506000135.628899-1-parav@nvidia.com>
 <20230507050146-mutt-send-email-mst@kernel.org>
 <71d65eb3-c025-9287-0157-81e1d05574d1@nvidia.com>
 <20230515155212-mutt-send-email-mst@kernel.org>
 <PH0PR12MB5481CDAD2698E8078BFFA4DFDC789@PH0PR12MB5481.namprd12.prod.outlook.com>
 <20230516002024-mutt-send-email-mst@kernel.org>
 <PH0PR12MB5481E016C2467E5C4CE8FD25DC799@PH0PR12MB5481.namprd12.prod.outlook.com>
MIME-Version: 1.0
In-Reply-To: <PH0PR12MB5481E016C2467E5C4CE8FD25DC799@PH0PR12MB5481.namprd12.prod.outlook.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Subject: [virtio-dev] Re: [virtio-comment] Re: [PATCH v2 0/2] transport-pci: Introduce
 legacy registers access using AQ

On Tue, May 16, 2023 at 06:45:58PM +0000, Parav Pandit wrote:
> > From: Michael S. Tsirkin <mst@redhat.com>
> > Sent: Tuesday, May 16, 2023 12:33 AM
> 
> [..]
> > > > > A better way is to have an eventq of depth = num_vfs, like many
> > > > > other virtio devices have it.
> > > > >
> > > > > An eventq can hold per VF interrupt entry including the isr value
> > > > > that you suggest above.
> > > > >
> > > > > Something like,
> > > > >
> > > > > union eventq_entry {
> > > > > 	u8 raw_data[16];
> > > > > 	struct intx_entry {
> > > > > 		u8 event_opcode;
> > > > > 		u8 group_type;
> > > > > 		u8 reserved[6];
> > > > > 		le64 group_identifier;
> > > > > 		u8 isr_status;
> > > > > 	};
> > > > > };
> > > > >
> > > > > This eventq resides on the owner parent PF.
> > > > > isr_status is read on clear like today.
> > > >
> > > > This is what I wrote no?
> > > > lore.kernel.org/all/20230507050146-mutt-send-email-
> > > > mst%40kernel.org/t.mbox.gz
> > > >
> > > > 	how about a special command that is used when device would
> > > > 	normally send INT#x? it can also return ISR to reduce latency.
> > > >
> > > In response to your above suggestion of AQ command, I suggested the
> > > eventq that contains the isr_status that reduces latency as you suggest.
> > 
> > I don't see why we need to keep adding queues though.
> > Just use one of admin queues.
> > 
> Admin queue is cmd->rsp mode.
> The purpose is different here. A device wants to async, notify the interrupt for each VF.
> Like a nic rq.
> Filling up the AQ full of these commands is sub-optimal for those VFs who may generate interrupt.

I don't get the difference sorry. what you do with rq
is exactly fill it up with buffers. here you fill adminq with
commands.



> > > An eventq is a variation of it, where device can keep reporting the events
> > without doing the extra mapping and without too many commands.
> > 
> > I don't get the difference then. The format you showed seems very close to
> > admin command. What is the difference? How do you avoid the need to add a
> > command per VF using INTx#?
> > 
> The main difference is it behaves like nic rq.
> Driver posts empty descriptors, device reports the consumed entries.
> Specific entry is not attached to any specific VF.
> The eventq_entry structure is written by the device for a VF there fired the interrupt fired.

If this is what you want, we already have commands that do not refer to
a specific VF, specifically VIRTIO_ADMIN_CMD_LIST_QUERY.
But I think this is misguided see below.


> > How do you avoid the need to add a command per VF using INTx#?
> The empty buffer is posted pointing to eventq_entry.
> Total number of buffers posted = number_of_vfs in intx mode.
> So entry is not attached to a specific VF, entries are in a pool (like nic rq).

There is a very simple problem with your approach:
you need to report to VF read of ISR since that
clears the interrupt line.
This command has to be per VF.
As I tried to explain before, I proposed combining the two:
same command clears ISR for a VF and if ISR is not 0
returns immediately. If it is 0 the buffer is queued and
used later for interrupt. I prefer the approach
where the buffer is reused by the same VF,
relying on out of order use.
But yes, if you want use in-order, this does not work.
Write the VF that triggered interrupt in command specific
data maybe?



> > > Intel CPU has 256 per core (per vcpu). So they are really a lot.
> > > One needs to connect lot more devices to the cpu to run out of it.
> > > So yes, I would like to try the command to fail.
> > 
> > order of 128 functions then for a 1vcpu VM. You were previously talking about
> > tends of 1000s of functions as justification for avoiding config space.
> > 
> Will try.
> 
> > 
> > > > Do specific customers event use guests with msi-x disabled? Maybe no.
> > > > Does anyone use virtio with msi-x disabled? Most likely yes.
> > > I just feel that INTx emulation is extremely rare/narrow case of some
> > applications that may never find its use on hw based devices.
> > 
> > If we use a dedicated command for this, I guess devices can just avoid
> > implementing the command if they do not feel like it?
> > 
> I didn't follow. The guest device?
> Do you mean guest driver?

Device. Clear the bit in VIRTIO_ADMIN_CMD_LIST_QUERY and
then hypervisor knows it can't support INTx.

> > > A driver will be easily able to fail the call on INTx configuration failing the
> > guest.
> > 
> > There's no configuration - INTx is the default - and no way to fail gracefully for
> > legacy. That is one of the things we should fix, at least hypervisor should be able
> > to detect failures.
> For sure hypervisor can detect the failure on INTx configuration done by the guest and fail the call for this config.
> What we are discussing is not anything legacy specific, it applies to 1.x as well sadly.

Problem is, enabling MSIX changes layout for legacy.
This is my concern really we need to make the decision whether the
reserved msi vector hack is used or eventq will work. Because
reserved msi vector hack changes legacy layout.
Fundamentally, that only matters because you insist on
reusing the same command for common and device config space
access with difference in the offset. Split them out as Jason proposed
and the issue goes away.

> So, we don't need to mix INTx support with register emulation proposal, better to handle in the follow up proposal itself.
> I also have some patches to improve driver resiliency when guest is not involved to work without INTx.
> 
> And INTx can still work from system and device point of view, because INTx generation does not have function id in it.
> Existing PCIe INTx can work if PCI PF device can trigger INTx for the VFs.
> So eventq scheme is still optional and orthogonal to legacy.
> 
> I would like to discuss it separately outside of legacy proposal.

Hmm this sounds convincing. I think if we split device and common
config then we can defer INTx issue.

-- 
MST


---------------------------------------------------------------------
To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org

