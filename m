Return-Path: <virtio-dev-return-12224-virtio-dev=archiver.kernel.org@lists.oasis-open.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from ws5-mx01.kavi.com (ws5-mx01.kavi.com [34.193.7.191])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 15B4BC77B61
	for <virtio-dev@archiver.kernel.org>; Fri, 14 Apr 2023 03:18:37 +0000 (UTC)
Received: from lists.oasis-open.org (oasis.ws5.connectedcommunity.org [10.110.1.242])
	by ws5-mx01.kavi.com (Postfix) with ESMTP id 696382B06E
	for <virtio-dev@archiver.kernel.org>; Fri, 14 Apr 2023 03:18:36 +0000 (UTC)
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id 506F8986613
	for <virtio-dev@archiver.kernel.org>; Fri, 14 Apr 2023 03:18:36 +0000 (UTC)
Received: from host09.ws5.connectedcommunity.org (host09.ws5.connectedcommunity.org [10.110.1.97])
	by lists.oasis-open.org (Postfix) with QMQP
	id 3B666983D9C; Fri, 14 Apr 2023 03:18:36 +0000 (UTC)
Mailing-List: contact virtio-dev-help@lists.oasis-open.org; run by ezmlm
List-ID: <virtio-dev.lists.oasis-open.org>
Sender: <virtio-dev@lists.oasis-open.org>
Precedence: bulk
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id 2901F986601
	for <virtio-dev@lists.oasis-open.org>; Fri, 14 Apr 2023 03:18:36 +0000 (UTC)
X-Virus-Scanned: amavisd-new at kavi.com
X-MC-Unique: ETq87ANCO2OhCj1p_SQwbQ-1
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1681442313; x=1684034313;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=0zkUdRg+ETa/JiayojkiCyuEzqW8vVvZPJxYLcIWisg=;
        b=Mbaj3Ggtu3zOBUK8Cd6s4/bDigtdDuNtKSs0eTCP2P+bifG7EcX12DW9GGAe+t9KBU
         vx3L1+Olv6W4NGM9hTx6MJFwzbeBtcYJn+NmZ9fRs1kf0gmnU0yJnHJrI8Zpz10XXOYS
         VNKgFFNDXh2a9sM2mLdJ9xu8blaEHozVVrHaf5F3x+/hK5nickMXHJRF1OY6u5s5UwXo
         JppJOvjoG2zyQVKzUal3sT7NSYJ6qmrj8X6x63cBRe1JnT8dcCEeoDQW8N4wywzwF6Jh
         gEl6fFlpq4eNVj1fsWAgVspRWdFlJpr4m35vvduZ1ZAp7d9iIxagzH4xf2j/8bEjnitP
         F6Sw==
X-Gm-Message-State: AAQBX9e3j99aJCwZrV2u0domGJ5HrILuBRo/S1ir5C1A0IxOHGVj9+4U
	JYieI6UXB+ArY6qp884i8YyNn4Fqjis8XYhiZu1bYDZi+frrat3UdHoteTurbhMg8EqJQL19GZg
	G6tMm4d6xvpais7CsiJenIaO2/SFHUH9uOAsJRMhtr4UD
X-Received: by 2002:aca:f0b:0:b0:387:5a8c:4125 with SMTP id 11-20020aca0f0b000000b003875a8c4125mr826634oip.3.1681442313636;
        Thu, 13 Apr 2023 20:18:33 -0700 (PDT)
X-Google-Smtp-Source: AKy350Y1csTUNKsjXsz+GuFwrcQhL7vLA0j2pXk5OM8vVP9avGuDjp7YsMTiY1SfV4fGuUl7FY05wqlvNUEKuqsUWmI=
X-Received: by 2002:aca:f0b:0:b0:387:5a8c:4125 with SMTP id
 11-20020aca0f0b000000b003875a8c4125mr826625oip.3.1681442313373; Thu, 13 Apr
 2023 20:18:33 -0700 (PDT)
MIME-Version: 1.0
References: <20230410020906-mutt-send-email-mst@kernel.org>
 <CACGkMEufWUXHKahg3GLOKfV5aptbiek_DKwy+7rCfMya2GPaTQ@mail.gmail.com>
 <20230412000802-mutt-send-email-mst@kernel.org> <CACGkMEshNydwBD=Q0JW-SDY6xyiJ4uVrLn+pxbUrinycBKwsrw@mail.gmail.com>
 <PH0PR12MB548118F57BB4B4A4F8DC9D7ADC9B9@PH0PR12MB5481.namprd12.prod.outlook.com>
 <CACGkMEvYsz1fSPG+fKpRaZ05Ut7ffKwvMPvR8xbRBsXA_6vGQw@mail.gmail.com>
 <PH0PR12MB548137D7A25C99EAA42B4D12DC9B9@PH0PR12MB5481.namprd12.prod.outlook.com>
 <CACGkMEshW82qztmGw8YJWJ8=QCoRd6cPxQ+ySazxsO_o+U6c4Q@mail.gmail.com>
 <PH0PR12MB548147CF939CB9C2A0586310DC9B9@PH0PR12MB5481.namprd12.prod.outlook.com>
 <CACGkMEu2B_GogDR9HUwB7mT8fkGh+Q_buPLz4nhwhK7h9k6BQQ@mail.gmail.com>
 <PH0PR12MB5481F0CF5A555A6BB2CE856CDC9B9@PH0PR12MB5481.namprd12.prod.outlook.com>
 <CACGkMEuNOYOxvcSzrs0UFEyk+xOkGUpOfhK8rOy_Mebz5b5wdg@mail.gmail.com>
 <a74d3107-d38c-df15-e2ff-f848635f24bd@nvidia.com> <CACGkMEt+bGN7UYEopXPj0+deAnYm1VUNp05VvGHcJnkd8LzbGg@mail.gmail.com>
 <f9f01f9d-f6ec-0daa-a11d-c75589dcbe6c@nvidia.com> <CACGkMEskPJgNrBQV10ieSaKCg_kBbi2E0z1BEbdyiiaDdD1zJA@mail.gmail.com>
 <PH0PR12MB54815F0A67A14691CA64D2B4DC999@PH0PR12MB5481.namprd12.prod.outlook.com>
In-Reply-To: <PH0PR12MB54815F0A67A14691CA64D2B4DC999@PH0PR12MB5481.namprd12.prod.outlook.com>
From: Jason Wang <jasowang@redhat.com>
Date: Fri, 14 Apr 2023 11:18:22 +0800
Message-ID: <CACGkMEsYYQTMdhPy2oVoP=2B9jcK+OJ_TPHqdEsip_pjZvyiOA@mail.gmail.com>
To: Parav Pandit <parav@nvidia.com>
Cc: "Michael S. Tsirkin" <mst@redhat.com>, 
	"virtio-dev@lists.oasis-open.org" <virtio-dev@lists.oasis-open.org>, "cohuck@redhat.com" <cohuck@redhat.com>, 
	"virtio-comment@lists.oasis-open.org" <virtio-comment@lists.oasis-open.org>, Shahaf Shuler <shahafs@nvidia.com>, 
	Satananda Burla <sburla@marvell.com>, Maxime Coquelin <maxime.coquelin@redhat.com>, 
	Yan Vugenfirer <yan@daynix.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Subject: [virtio-dev] Re: [virtio-comment] Re: [PATCH 09/11] transport-pci: Describe PCI
 MMR dev config registers

On Fri, Apr 14, 2023 at 11:13=E2=80=AFAM Parav Pandit <parav@nvidia.com> wr=
ote:
>
>
>
> > From: Jason Wang <jasowang@redhat.com>
> > Sent: Thursday, April 13, 2023 11:09 PM
>
> >
> > Actually not, I think I've mentioned the reason for several times:
> >
> > It's a must for ABI and migration compatibility:
> >
> > 1) The offset is not necessarily a page boundary
> > 2) The length is not necessarily times of a PAGE_SIZE
> > 3) PAGE_SIZE varies among different archs
> > 4) Two vendors may have two different layout for the structure
>
> Migration compatibility check and device composition work will start for =
regular PCI VF in virtio.
> Two vendors will had some level of programmability as well to make this h=
appen.
> It is orthogonal topic.

Actually not, having new blockers for live migration will complicate
the solution in the future.

And 1) 2) 3) can happen even if we don't care about migration compatibility=
, no?

Thanks


---------------------------------------------------------------------
To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org

