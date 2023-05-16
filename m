Return-Path: <virtio-dev-return-12713-virtio-dev=archiver.kernel.org@lists.oasis-open.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from ws5-mx01.kavi.com (ws5-mx01.kavi.com [34.193.7.191])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B2C74C77B7F
	for <virtio-dev@archiver.kernel.org>; Tue, 16 May 2023 04:33:00 +0000 (UTC)
Received: from lists.oasis-open.org (oasis.ws5.connectedcommunity.org [10.110.1.242])
	by ws5-mx01.kavi.com (Postfix) with ESMTP id 110AA2AD7A
	for <virtio-dev@archiver.kernel.org>; Tue, 16 May 2023 04:33:00 +0000 (UTC)
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id EE1D39865BA
	for <virtio-dev@archiver.kernel.org>; Tue, 16 May 2023 04:32:59 +0000 (UTC)
Received: from host09.ws5.connectedcommunity.org (host09.ws5.connectedcommunity.org [10.110.1.97])
	by lists.oasis-open.org (Postfix) with QMQP
	id E1258986512; Tue, 16 May 2023 04:32:59 +0000 (UTC)
Mailing-List: contact virtio-dev-help@lists.oasis-open.org; run by ezmlm
List-ID: <virtio-dev.lists.oasis-open.org>
Sender: <virtio-dev@lists.oasis-open.org>
Precedence: bulk
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id CB89D986511
	for <virtio-dev@lists.oasis-open.org>; Tue, 16 May 2023 04:32:59 +0000 (UTC)
X-Virus-Scanned: amavisd-new at kavi.com
X-MC-Unique: Cbr2sRpDPZKHjRfh3wUOZg-1
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684211573; x=1686803573;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=66C451vonlRvjmxruFCHGdOAEoj9yIruLVEkhHhmM/M=;
        b=L9hlFfVS3WSX0nHZ9wYtQoPxYhVJur4TyaZTgvjMeMd5YY8FZL5m6rIdqdmk3RSJ+7
         Bc9T/nCzcNgqF5UWkHP62hc7g6/4LNjygZWJ+w+69WEy1vKNMjIIPqE2p0F5tJbP27U1
         Tkd9AgB7/Fe8aJw49S6OzVKxANWkJOm2tfB3n5O7EpfgIKsjBcIKnlEwwNw9lkV/6Acb
         8RnXDbE8Z4UdUHsJ1iRj4IP8oojYUu3cuXTyodtD5HgR+Dyg9vRfu6zzpw580866GUlH
         fBTueu+6PC39vYHjUM8ozJtOA2BkexkvB7hZdJGJP6J9D7I/OttiGE50r/ryv6VtaWa7
         fzow==
X-Gm-Message-State: AC+VfDz+8+zhOWG1+baeT3V4G5bAoiO3HHiBkWQHldCgoKbpTxJuY5BZ
	836dPBWKtp4KF7A37YvDcKoI3qw98HmpweWeuHQfhWIMhiCI9jndS3GJXPicyThKAsWlnHWwm5R
	S5eRS0itSgMyQvzx5DtHvx4L/XtqS
X-Received: by 2002:a5d:414e:0:b0:309:31ac:6663 with SMTP id c14-20020a5d414e000000b0030931ac6663mr533687wrq.16.1684211573632;
        Mon, 15 May 2023 21:32:53 -0700 (PDT)
X-Google-Smtp-Source: ACHHUZ7n7UdRhRn/nm17gmtF312M2tUSi9/Bef+xfg+6ghTQttsW1uYgBVHLyObHN3Dnz68fEc00lw==
X-Received: by 2002:a5d:414e:0:b0:309:31ac:6663 with SMTP id c14-20020a5d414e000000b0030931ac6663mr533671wrq.16.1684211573336;
        Mon, 15 May 2023 21:32:53 -0700 (PDT)
Date: Tue, 16 May 2023 00:32:48 -0400
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
Message-ID: <20230516002024-mutt-send-email-mst@kernel.org>
References: <20230506000135.628899-1-parav@nvidia.com>
 <20230507050146-mutt-send-email-mst@kernel.org>
 <71d65eb3-c025-9287-0157-81e1d05574d1@nvidia.com>
 <20230515155212-mutt-send-email-mst@kernel.org>
 <PH0PR12MB5481CDAD2698E8078BFFA4DFDC789@PH0PR12MB5481.namprd12.prod.outlook.com>
MIME-Version: 1.0
In-Reply-To: <PH0PR12MB5481CDAD2698E8078BFFA4DFDC789@PH0PR12MB5481.namprd12.prod.outlook.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Subject: [virtio-dev] Re: [virtio-comment] Re: [PATCH v2 0/2] transport-pci: Introduce
 legacy registers access using AQ

On Mon, May 15, 2023 at 08:56:42PM +0000, Parav Pandit wrote:
> 
> 
> > From: Michael S. Tsirkin <mst@redhat.com>
> > Sent: Monday, May 15, 2023 4:30 PM
> > >
> > > I am not sure if this is a real issue. Because even the legacy guests
> > > have msix enabled by default. In theory yes, it can fall back to intx.
> > 
> > Well. I feel we should be closer to being sure it's not an issue if we are going to
> > ignore it.
> > some actual data here:
> > 
> > Even linux only enabled MSI-X in 2009.
> > Of course, other guests took longer. E.g.
> > a quick google search gave me this for some bsd variant (2017):
> > https://twitter.com/dragonflybsd/status/834494984229421057
> > 
> > Many guests have tunables to disable msix. Why?
> > E.g. BSD keeps maintaining it at
> >      hw.virtio.pci.disable_msix
> > not a real use-case and you know 100% no guests have set this to work around
> > some bug e.g. in bsd MSI-X core?  How can you be sure?
> > 
> > 
> > 
> > intx is used when guests run out of legacy interrupts, these setups are not hard
> > to create at all: just constrain the number of vCPUs while creating lots of
> > devices.
> > 
> > 
> > I could go on.
> > 
> > 
> > 
> > > There are few options.
> > > 1. A hypervisor driver can be conservative and steal an msix of the VF
> > > for transporting intx.
> > > Pros: Does not need special things in device
> > > Cons:
> > > a. Fairly intrusive in hypervisor vf driver.
> > > b. May not be ever used as guest is unlikely to fail on msix
> > 
> > Yea I do not like this since we are burning up msix vectors.
> > More reasons: this "pass through" msix has no chance to set ISR properly since
> > msix does not set ISR.
> > 
> > 
> > > 2. Since multiple VFs intx to be serviced, one command per VF in AQ is
> > > too much overhead that device needs to map a request to,
> > >
> > > A better way is to have an eventq of depth = num_vfs, like many other
> > > virtio devices have it.
> > >
> > > An eventq can hold per VF interrupt entry including the isr value that
> > > you suggest above.
> > >
> > > Something like,
> > >
> > > union eventq_entry {
> > > 	u8 raw_data[16];
> > > 	struct intx_entry {
> > > 		u8 event_opcode;
> > > 		u8 group_type;
> > > 		u8 reserved[6];
> > > 		le64 group_identifier;
> > > 		u8 isr_status;
> > > 	};
> > > };
> > >
> > > This eventq resides on the owner parent PF.
> > > isr_status is read on clear like today.
> > 
> > This is what I wrote no?
> > lore.kernel.org/all/20230507050146-mutt-send-email-
> > mst%40kernel.org/t.mbox.gz
> > 
> > 	how about a special command that is used when device would
> > 	normally send INT#x? it can also return ISR to reduce latency.
> > 
> In response to your above suggestion of AQ command,
> I suggested the eventq that contains the isr_status that reduces latency as you suggest.

I don't see why we need to keep adding queues though.
Just use one of admin queues.

> > > May be such eventq can be useful in future for wider case.
> > 
> > There's no maybe here is there? Things like live migration need events for sure.
> > 
> > > We may have to find a different name for it as other devices has
> > > device specific eventq.
> > 
> > We don't need a special name for it. Just use an adminq with a special
> > command that is only consumed when there is an event.
> This requires too many commands to be issued on the PF device.
> Potentially one per VF. And device needs to keep track of command to VF mapping.
>
> > Note you only need to queue a command if MSI is disabled.
> > Which is nice.
> Yes, it is nice.
> An eventq is a variation of it, where device can keep reporting the events without doing the extra mapping and without too many commands.

I don't get the difference then. The format you showed seems very close
to admin command. What is the difference? How do you avoid the need
to add a command per VF using INTx#?


> Additionally, eventq also works for 1.x device which will read the ISR status registers directly from the device.
> 
> > 
> > > I am inclined to differ this to a later point if one can identify the
> > > real failure with msix for the guest VM.
> > > So far we don't see this ever happening.
> > 
> > What is the question exactly?
> > 
> > Just have more devices than vectors,
> > an intel CPU only has ~200 of these, and current drivers want to use 2 vectors
> > and then fall back on INTx since that is shared.
> > Extremely easy to create - do you want a qemu command line to try?
> > 
> Intel CPU has 256 per core (per vcpu). So they are really a lot.
> One needs to connect lot more devices to the cpu to run out of it.
> So yes, I would like to try the command to fail.

order of 128 functions then for a 1vcpu VM. You were previously talking
about tends of 1000s of functions as justification for avoiding config
space.


> > Do specific customers event use guests with msi-x disabled? Maybe no.
> > Does anyone use virtio with msi-x disabled? Most likely yes.
> I just feel that INTx emulation is extremely rare/narrow case of some applications that may never find its use on hw based devices.

If we use a dedicated command for this, I guess devices can just
avoid implementing the command if they do not feel like it?

> > So if we are going for legacy pci emulation let's have a comprehensive legacy
> > pci emulation please where host can either enable it for a guest or deny
> > completely, not kind of start running then fail mysteriously.
> A driver will be easily able to fail the call on INTx configuration failing the guest.

There's no configuration - INTx is the default - and no way to fail gracefully
for legacy. That is one of the things we should fix, at least hypervisor
should be able to detect failures.

> But lets see if can align to eventq/aq scheme to make it work.


---------------------------------------------------------------------
To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org

