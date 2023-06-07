Return-Path: <virtio-dev-return-12877-virtio-dev=archiver.kernel.org@lists.oasis-open.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from ws5-mx01.kavi.com (ws5-mx01.kavi.com [34.193.7.191])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DA9A6C7EE29
	for <virtio-dev@archiver.kernel.org>; Wed,  7 Jun 2023 06:54:38 +0000 (UTC)
Received: from lists.oasis-open.org (oasis.ws5.connectedcommunity.org [10.110.1.242])
	by ws5-mx01.kavi.com (Postfix) with ESMTP id 1E664190906
	for <virtio-dev@archiver.kernel.org>; Wed,  7 Jun 2023 06:54:38 +0000 (UTC)
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id 0726A986655
	for <virtio-dev@archiver.kernel.org>; Wed,  7 Jun 2023 06:54:38 +0000 (UTC)
Received: from host09.ws5.connectedcommunity.org (host09.ws5.connectedcommunity.org [10.110.1.97])
	by lists.oasis-open.org (Postfix) with QMQP
	id E335E986647; Wed,  7 Jun 2023 06:54:37 +0000 (UTC)
Mailing-List: contact virtio-dev-help@lists.oasis-open.org; run by ezmlm
List-ID: <virtio-dev.lists.oasis-open.org>
Sender: <virtio-dev@lists.oasis-open.org>
Precedence: bulk
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id CC20D98664A
	for <virtio-dev@lists.oasis-open.org>; Wed,  7 Jun 2023 06:54:37 +0000 (UTC)
X-Virus-Scanned: amavisd-new at kavi.com
X-MC-Unique: O1bmDyHyMD6yImjqj4GcXA-1
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686120874; x=1688712874;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=/PU+oRLb3v0baA5txgeSEjG08KYUEYh0eQg6RDMz/Dc=;
        b=LnpW24AiYs/43ICu/DITZ8diR6K8Mz3VgdV9U46meI4VJTkQhad0YCrL+yZYiDpLiH
         f/8pz+uR8a7I1PAJXPXjYCV2ZENiX5yCXN6/Mlky/7wmAooVt5wpZAIIXd5TLHcqcnQP
         2qum0+urDMM7QnT+bfn/YrsBzaap2ysP4JREPwFDxatSJcfar5QJbPvcF2CfKV4uCg6C
         ERCM2DY1d51g5fNJm5RD1GV65HNS7iZbVNMK6MQFndgU3k2OvmNpg6tDAZSLdcPOPwla
         d3+3c9I8TxuBDqbn/k9NsfoX0VhzwPLx7mn9Av9PgZJi1yYzOZUnwIXcaLinzJQwv4Nz
         ZcAg==
X-Gm-Message-State: AC+VfDyJHM9nbkQ2hxnpNBrYXJzOBG+6Rj/EdLSad2E7thpajs/oBU0m
	phhkcg1aofZmiVx2ywCM+5dmSJwXg8a4W+qpxTrksMY7LdIP9YaxD62BhBBeATk8hdlKULoLppJ
	Me0LVVvkJq6/OnaDYvEbFg6+WyzF/krAB4VWF6yBFOP78
X-Received: by 2002:a2e:b16f:0:b0:2b1:ad0e:7361 with SMTP id a15-20020a2eb16f000000b002b1ad0e7361mr1837882ljm.32.1686120874559;
        Tue, 06 Jun 2023 23:54:34 -0700 (PDT)
X-Google-Smtp-Source: ACHHUZ5cdk69sNP6fGBVDAooujNrFOJCxbk7PH5ICpjFxekRh0FXM1VKgbr5/X9UkEyj228XKGyVR/9AEG+sb/C+k08=
X-Received: by 2002:a2e:b16f:0:b0:2b1:ad0e:7361 with SMTP id
 a15-20020a2eb16f000000b002b1ad0e7361mr1837869ljm.32.1686120874193; Tue, 06
 Jun 2023 23:54:34 -0700 (PDT)
MIME-Version: 1.0
References: <20230604105027-mutt-send-email-mst@kernel.org>
 <PH0PR12MB5481B721C34D85D63FCC1F3DDC4CA@PH0PR12MB5481.namprd12.prod.outlook.com>
 <20230604174224-mutt-send-email-mst@kernel.org> <PH0PR12MB5481DABA25CA36A5460B13E5DC4CA@PH0PR12MB5481.namprd12.prod.outlook.com>
 <20230605014539-mutt-send-email-mst@kernel.org> <PH0PR12MB5481C14D65D5E10CD23A9F67DC4DA@PH0PR12MB5481.namprd12.prod.outlook.com>
 <20230605092859-mutt-send-email-mst@kernel.org> <PH0PR12MB5481CEB3A34AAB49A282F2A8DC4DA@PH0PR12MB5481.namprd12.prod.outlook.com>
 <20230605174755-mutt-send-email-mst@kernel.org> <PH0PR12MB548180E16376862A3C0DFF1DDC4DA@PH0PR12MB5481.namprd12.prod.outlook.com>
 <20230606073544-mutt-send-email-mst@kernel.org> <CACGkMEv1so_KGwJZG3GnAf=JNky7+BMNK7N4NTtucDS+WyW5VA@mail.gmail.com>
 <PH0PR12MB5481D80A48F3BD82D86B3DB0DC53A@PH0PR12MB5481.namprd12.prod.outlook.com>
In-Reply-To: <PH0PR12MB5481D80A48F3BD82D86B3DB0DC53A@PH0PR12MB5481.namprd12.prod.outlook.com>
From: Jason Wang <jasowang@redhat.com>
Date: Wed, 7 Jun 2023 14:54:22 +0800
Message-ID: <CACGkMEsVrqCGJJ2Q5OGbgPdtEJHTpvVt6nEKP_MzkSH_-cOa6w@mail.gmail.com>
To: Parav Pandit <parav@nvidia.com>
Cc: "Michael S. Tsirkin" <mst@redhat.com>, 
	"virtio-dev@lists.oasis-open.org" <virtio-dev@lists.oasis-open.org>, "cohuck@redhat.com" <cohuck@redhat.com>, 
	"david.edmondson@oracle.com" <david.edmondson@oracle.com>, "sburla@marvell.com" <sburla@marvell.com>, 
	Yishai Hadas <yishaih@nvidia.com>, Maor Gottlieb <maorg@nvidia.com>, 
	"virtio-comment@lists.oasis-open.org" <virtio-comment@lists.oasis-open.org>, Shahaf Shuler <shahafs@nvidia.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Subject: Re: [virtio-dev] Re: [PATCH v3 0/3] transport-pci: Introduce legacy
 registers access using AQ

On Wed, Jun 7, 2023 at 11:06=E2=80=AFAM Parav Pandit <parav@nvidia.com> wro=
te:
>
>
>
> > From: Jason Wang <jasowang@redhat.com>
> > Sent: Tuesday, June 6, 2023 10:27 PM
> >
> > I can't say I like this. I prefer to do meditation on top of a modern d=
evice with
> > some lightweight features like _F_LEAGCY_HEADER. I don't see any advant=
ages
> > of a new legacy ABI over _F_LEGACY_HEADER. I don't want to repeat but I=
 don't
> > get any response here
> >
> It is net only and not generic. Not a big blocker.
> It doesnt stop at _F_LEAGCY_HEADER.
>
> > Anything that prevents you from adding things like VIRTIO_NET_F_LEGACY_=
HEADER?
> It requires hypervisor to mediate 1.x config region and intercept feature=
 negotiation including q config and more.

For config region, do you mean device configuration space or common
config space?

I don't see why we need to do mediation on neiter of the above.
Hypervisor just need to prepare

1) legacy BAR with legacy config and device configuration space and
2) modern BAR with modern capabilities (common cfg and device cfg)

For 2) it could be mapped directly to the modern capabilities. For 1)
hypervisor needs to mediate

>
> Additionally, 1.x device says the mac address is read only, while legacy =
is RW.
> And that requires yet another feature bit negotiation.

Hypervisor can trap the legacy device configuration space write and
convert it to cvq commands.

Thanks

>
> The main design goal is to not mediate 1.x specific region and not modify=
 1.x region definitions.
> Which is why we step forward with the AQ.
>
> > https://lore.kernel.org/virtio-
> > dev/CACGkMEuixsBibSq_pEQvcKOH0WBQWnta4Q2c28SV8qTS8gaVcA@mail.g
> > mail.com/#t


---------------------------------------------------------------------
To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org

