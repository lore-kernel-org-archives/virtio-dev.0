Return-Path: <virtio-dev-return-12769-virtio-dev=archiver.kernel.org@lists.oasis-open.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from ws5-mx01.kavi.com (ws5-mx01.kavi.com [34.193.7.191])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4B6BAC77B7C
	for <virtio-dev@archiver.kernel.org>; Sun, 21 May 2023 14:33:19 +0000 (UTC)
Received: from lists.oasis-open.org (oasis.ws5.connectedcommunity.org [10.110.1.242])
	by ws5-mx01.kavi.com (Postfix) with ESMTP id 1FE7C142D67
	for <virtio-dev@archiver.kernel.org>; Sun, 21 May 2023 14:33:17 +0000 (UTC)
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id 1A443986197
	for <virtio-dev@archiver.kernel.org>; Sun, 21 May 2023 14:33:17 +0000 (UTC)
Received: from host09.ws5.connectedcommunity.org (host09.ws5.connectedcommunity.org [10.110.1.97])
	by lists.oasis-open.org (Postfix) with QMQP
	id 0671F9859E5; Sun, 21 May 2023 14:33:17 +0000 (UTC)
Mailing-List: contact virtio-dev-help@lists.oasis-open.org; run by ezmlm
List-ID: <virtio-dev.lists.oasis-open.org>
Sender: <virtio-dev@lists.oasis-open.org>
Precedence: bulk
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id E4D0E9859E8
	for <virtio-dev@lists.oasis-open.org>; Sun, 21 May 2023 14:33:15 +0000 (UTC)
X-Virus-Scanned: amavisd-new at kavi.com
X-MC-Unique: 3s_atRpoP46sVzub4Q8QGw-1
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684679590; x=1687271590;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=MA4GW2nnkL3E2dDXl8tw+jfP9C1kadozU8GYe7m1qTg=;
        b=aCLShmQnwk5GSr2+AzUVE7oLf/3c154lHoxkw5sdjGovBF44RlMCpIj2OnQxCk/mlb
         WGCLJNupgMAYXcUyr4s4OiSCMV86PAk8uGJ1UmeSIkfRVmJbP0HKayg4NpESND2YnYeH
         WmbXL7XL6MD3SZ/SFgSixtyoafnmwwaPbzc9WNXtjXQa65AdDdkf6U4hRyCQR8AXKOO1
         uCfM2p6uC2+Wl2UkRUbOyCLDQUWbP03mGVV73hQ5eVNfDPqWGavFnnS2f7bNO9yj7R0o
         QoaqeZOawNc1Lowjv76Jh4H9DTUMV1PYQtoRBoVG2h2b2rCgZwQuwKw1kzQq//O8Kj0t
         tw/Q==
X-Gm-Message-State: AC+VfDympHSlpbqHUJFwyx5mMLrqZBe+UDI6GtXu3I1Wtkcc5bfDl121
	vTfdb0wHqACbZcJ1evkTVKkvkPVnnOq/FECuftlFGx/aydmWTh9Wot20eu+YdcvZS1E6XIa4WAE
	AhvD61qh3s19UwRGVtPANV/oD5ugw
X-Received: by 2002:a5d:6091:0:b0:306:3361:6cbf with SMTP id w17-20020a5d6091000000b0030633616cbfmr5770595wrt.21.1684679590278;
        Sun, 21 May 2023 07:33:10 -0700 (PDT)
X-Google-Smtp-Source: ACHHUZ71HlMe1HP4Rjc8MOij4cCe+Bf+s5mbps+IGVEmePtTLmU2JU/UOQ7i3yY9LA98F9obuhhKig==
X-Received: by 2002:a5d:6091:0:b0:306:3361:6cbf with SMTP id w17-20020a5d6091000000b0030633616cbfmr5770578wrt.21.1684679589852;
        Sun, 21 May 2023 07:33:09 -0700 (PDT)
Date: Sun, 21 May 2023 10:33:05 -0400
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
Message-ID: <20230521102050-mutt-send-email-mst@kernel.org>
References: <20230506000135.628899-1-parav@nvidia.com>
 <20230506000135.628899-2-parav@nvidia.com>
 <20230517013839-mutt-send-email-mst@kernel.org>
 <PH0PR12MB54817CBB98900B83C4F30164DC7E9@PH0PR12MB5481.namprd12.prod.outlook.com>
 <20230518153640-mutt-send-email-mst@kernel.org>
 <20230519015520-mutt-send-email-mst@kernel.org>
 <PH0PR12MB5481AABA8A22DC088B5D7CFDDC7C9@PH0PR12MB5481.namprd12.prod.outlook.com>
 <20230521050829-mutt-send-email-mst@kernel.org>
 <PH0PR12MB548161A2D28C387C9AF23B81DC429@PH0PR12MB5481.namprd12.prod.outlook.com>
MIME-Version: 1.0
In-Reply-To: <PH0PR12MB548161A2D28C387C9AF23B81DC429@PH0PR12MB5481.namprd12.prod.outlook.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Subject: [virtio-dev] Re: [virtio-comment] RE: [PATCH v2 1/2] transport-pci: Introduce
 legacy registers access commands

On Sun, May 21, 2023 at 01:21:17PM +0000, Parav Pandit wrote:
> 
> > From: virtio-comment@lists.oasis-open.org <virtio-comment@lists.oasis-
> > open.org> On Behalf Of Michael S. Tsirkin
> > Sent: Sunday, May 21, 2023 5:17 AM
> 
> > > The Notification of the VFs are on the VF BAR for modern or legacy.
> > > One needs to build additional cross forwarding hardware from PF to VF for the
> > doorbells.
> > 
> > I think doorbells are driver notifications (linux driver calls them kicks)?
> > I don't understand what you are saying above really.
> > what can and what can't be done?
> >
> VF has the notification BAR region.
> All 1.x and legacy such notification lands on the VF BAR.
> 
> > Again all this idea (as opposed to Jason's transport vq) is to have a simple
> > software model. Attaching a driver to two devices at the same time is hard to
> > achive e.g. under windows.
> >
> Yet you initiate same discussion point that we already discussed again after summarizing.
> A driver is not attached to two devices.
> A driver is attached to a single device.

And that device is the owner no? to send commands?

> A device uses a parent/owner group device to access legacy.
> 
> Software model may evolve over time.
> 
> > 
> > > And it cannot utilize what already exists for 1.x VF.
> > >
> > >  > 2. It should be possible to send notifications through an admin
> > > command too,
> > > >    otherwise admin commands are an incomplete set of functionality.
> > > >
> > > Yes. it is only for the functionality. As we discussed in past already, this will not
> > get any performance.
> > 
> > Performance might be ok if hardware disables kicks most of the time.
> >
> Even for the first kick it is order of magnitude higher.
> Kicks is the natural tool for the low latency.
>  
> > 
> > > > 3. I feel using a capability to describe legacy notification
> > > >    area would be better just because we already have a
> > > >    structure for this. make it an express capability if you like.
> > > The AQ command interface is far more programable object than PCI capability
> > to return this admin info.
> > > Hence I prefer AQ cmd.
> > 
> > I feel your preferences for 1 and 3 conflict. If you really insist on kicks being on
> > VFs then at least let us make VF driver in the host simple. 
> It is straight forward.
> 
> If you prefer the "offset" example of past,
> 
> If (legacy_offset == queue_notify_offset)
>    *db = guest_supplied_q_notify_content;
> else 
>     virtio_net_send_aq_cmd();
> 
> "simple" is really a subjective term in this context.

yes this is qemu. sure.

So we have legacy emulation send commands to VF or to PF.  Okay. But let
us avoid the need for VF driver to send commands to PF to initialize.
Just get all information it needs from VF itself.


Maybe it's a good idea to reuse existing notification capability,
or maybe a new one, but let's avoid making VF driver depend on PF
commands.



> > If it has to talk to PF
> > driver things are really complex. At this point we are very very far from VFIO
> > model, and then what exactly have we gained by implementing legacy control
> > path in hardware? 
> It is in the VFIO model, legacy largely falls in the special path for backward compat for the hw devices.
> 
> > Let's do software with maybe a couple of features such as
> > VIRTIO_NET_F_LEGACY_HEADER.
> >
> We have already these design choices and tradeoff in v0 and v1, it doesn't fit the requirements.

BTW not for this project but generally this is why I thought it is not
at all a bad idea to have a requirements text document e.g. under
todo/
discuss it as normally maybe even vote on including features in a
plan for a release.

> We cannot iterate exact 100% same points again in this summary discussion.
> 
> If you have any different comments from v0 and v1, please share, otherwise these commands should proceed.
> 
> What you hint is saying hey, "transport everything through the PF, then why do you have a VF?"
> We again past that discussion.
> 
> This is different requirement, than 
> "There is a VF passthrough accessible directly from the guest without a VI, some of them need to have legacy support also".
> Hence how do one make that legacy guest utilize it the VF in passthrough manner for 1.x and 0.9.5.
> With this proposal 0.9.5 slow registers are accessed over the owner group admin PF keeping the whole model and functionality intact.
> 
> This is it.


So, I am saying one model is small driver for VF and a big one for PF.
And to keep the VF driver simple, it should get information simply from
config space capability.



-- 
MST


---------------------------------------------------------------------
To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org

