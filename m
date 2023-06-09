Return-Path: <virtio-dev-return-12910-virtio-dev=archiver.kernel.org@lists.oasis-open.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from ws5-mx01.kavi.com (ws5-mx01.kavi.com [34.193.7.191])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E4E38C7EE23
	for <virtio-dev@archiver.kernel.org>; Fri,  9 Jun 2023 02:06:59 +0000 (UTC)
Received: from lists.oasis-open.org (oasis.ws5.connectedcommunity.org [10.110.1.242])
	by ws5-mx01.kavi.com (Postfix) with ESMTP id 531F042829
	for <virtio-dev@archiver.kernel.org>; Fri,  9 Jun 2023 02:06:59 +0000 (UTC)
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id 4AE4698669C
	for <virtio-dev@archiver.kernel.org>; Fri,  9 Jun 2023 02:06:59 +0000 (UTC)
Received: from host09.ws5.connectedcommunity.org (host09.ws5.connectedcommunity.org [10.110.1.97])
	by lists.oasis-open.org (Postfix) with QMQP
	id 3F58B9842E9; Fri,  9 Jun 2023 02:06:59 +0000 (UTC)
Mailing-List: contact virtio-dev-help@lists.oasis-open.org; run by ezmlm
List-ID: <virtio-dev.lists.oasis-open.org>
Sender: <virtio-dev@lists.oasis-open.org>
Precedence: bulk
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id 2F3CB98668E
	for <virtio-dev@lists.oasis-open.org>; Fri,  9 Jun 2023 02:06:59 +0000 (UTC)
X-Virus-Scanned: amavisd-new at kavi.com
X-MC-Unique: G6SVoHvdOC6XaoexsQ0KvA-1
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686276415; x=1688868415;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=LkD5yHjRHRAJLHdRCitoaW+ciw33OMihO26f3FWvzEA=;
        b=WpSBeZLfezn12Q+/ILTVk1zVxkd1RbSgbCtq2b8fgJx4qx5BAvMWiISCh8rqJJ46wy
         0RLxcryBKye+KvaA1CziyZ0n/Ac9n4q3HelTfIU/HQvf9T/DX+PvKfR6eG0G8H4A6xlr
         v+OGu5oBUezuEpvblbgOha6AAYQNju22x+1T2mc2Zhtes3jtjm0UI7pjN6Sn/ieXFCDI
         gKtGVTggLLDCyq2RCgQgiykxESt2VeX7JGTEhdLk4HDFJTgq6/lxXATMidTWzyZrT2Ye
         Km3U2gdmbxnK9F7dACsfDc8fGayUhl2s1nzflF5dY71ZZCH3NDMX8dMjKQ59yZNVT6Jt
         sSJQ==
X-Gm-Message-State: AC+VfDx2WzUBMwZ56fLTOeekDy9Ho9Z6FswloWZFiltuNQlevdNW0Hg5
	Tm+70a1TzEHCEWtB5hwEPQXtHKG+J4D9azUPpSvq2IDT8j3pyXls7WKghoUXDPWKJen/BG3b+/u
	scTQrDwF8V6flJdRzOD49hryxWjTuxXDkYH9yrvMguGjL
X-Received: by 2002:a05:6512:614:b0:4f5:a181:97b8 with SMTP id b20-20020a056512061400b004f5a18197b8mr20796lfe.25.1686276415701;
        Thu, 08 Jun 2023 19:06:55 -0700 (PDT)
X-Google-Smtp-Source: ACHHUZ5pkjHpYV/8n5W7rrMqS0I9dK/mToSHCPTJiN7cCL6gg2lCaf2anYY3+jqybPowcNyl0pkdPNRyZc0S4etAAgk=
X-Received: by 2002:a05:6512:614:b0:4f5:a181:97b8 with SMTP id
 b20-20020a056512061400b004f5a18197b8mr20782lfe.25.1686276415362; Thu, 08 Jun
 2023 19:06:55 -0700 (PDT)
MIME-Version: 1.0
References: <20230604105027-mutt-send-email-mst@kernel.org>
 <PH0PR12MB5481B721C34D85D63FCC1F3DDC4CA@PH0PR12MB5481.namprd12.prod.outlook.com>
 <20230604174224-mutt-send-email-mst@kernel.org> <PH0PR12MB5481DABA25CA36A5460B13E5DC4CA@PH0PR12MB5481.namprd12.prod.outlook.com>
 <20230605014539-mutt-send-email-mst@kernel.org> <PH0PR12MB5481C14D65D5E10CD23A9F67DC4DA@PH0PR12MB5481.namprd12.prod.outlook.com>
 <20230605092859-mutt-send-email-mst@kernel.org> <PH0PR12MB5481CEB3A34AAB49A282F2A8DC4DA@PH0PR12MB5481.namprd12.prod.outlook.com>
 <20230605174755-mutt-send-email-mst@kernel.org> <PH0PR12MB548180E16376862A3C0DFF1DDC4DA@PH0PR12MB5481.namprd12.prod.outlook.com>
 <20230606073544-mutt-send-email-mst@kernel.org> <CACGkMEv1so_KGwJZG3GnAf=JNky7+BMNK7N4NTtucDS+WyW5VA@mail.gmail.com>
 <PH0PR12MB5481D80A48F3BD82D86B3DB0DC53A@PH0PR12MB5481.namprd12.prod.outlook.com>
 <CACGkMEsVrqCGJJ2Q5OGbgPdtEJHTpvVt6nEKP_MzkSH_-cOa6w@mail.gmail.com> <PH0PR12MB54810313CA6DD1995F52745DDC50A@PH0PR12MB5481.namprd12.prod.outlook.com>
In-Reply-To: <PH0PR12MB54810313CA6DD1995F52745DDC50A@PH0PR12MB5481.namprd12.prod.outlook.com>
From: Jason Wang <jasowang@redhat.com>
Date: Fri, 9 Jun 2023 10:06:43 +0800
Message-ID: <CACGkMEsy=pG=LT0hOT-PO3HTkk3NOAu6qA_GaZpKwqq8B996cA@mail.gmail.com>
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

On Thu, Jun 8, 2023 at 10:38=E2=80=AFPM Parav Pandit <parav@nvidia.com> wro=
te:
>
>
> > From: Jason Wang <jasowang@redhat.com>
> > Sent: Wednesday, June 7, 2023 2:54 AM
>
> > Hypervisor can trap the legacy device configuration space write and con=
vert it
> > to cvq commands.
> Michael already answered that cvq is not trapped; this is the main design=
 goal we talked several times that it is passthrough device.

Is this really a blocker? Wouldn't a new feature(_F_LEFACY_MAC) or cap
resolve this?

>
> So no point discussing this again.
>
> If you have any comments on v4, please let me know.
>
> Both the design points are addressed in v4.
> 1. To split to two commands for device and config area
> 2. Use pci cap to learn about notification region
>
> Since this ABI reflects what we agree on,

I think not since you fail to explain why this approach is better than
simply adding new features like _F_LEGACY_HEADER and _F_LEGACY_MAC.

Thanks

> I would want to raise for vote in coming days to be part of 1.3 in few da=
ys as we have more than 3 weeks to sort out non-ABI language part.


---------------------------------------------------------------------
To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org

