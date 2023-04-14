Return-Path: <virtio-dev-return-12227-virtio-dev=archiver.kernel.org@lists.oasis-open.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from ws5-mx01.kavi.com (ws5-mx01.kavi.com [34.193.7.191])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 13DE8C77B71
	for <virtio-dev@archiver.kernel.org>; Fri, 14 Apr 2023 03:30:13 +0000 (UTC)
Received: from lists.oasis-open.org (oasis.ws5.connectedcommunity.org [10.110.1.242])
	by ws5-mx01.kavi.com (Postfix) with ESMTP id 5606929FE4
	for <virtio-dev@archiver.kernel.org>; Fri, 14 Apr 2023 03:30:12 +0000 (UTC)
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id 3C227986614
	for <virtio-dev@archiver.kernel.org>; Fri, 14 Apr 2023 03:30:12 +0000 (UTC)
Received: from host09.ws5.connectedcommunity.org (host09.ws5.connectedcommunity.org [10.110.1.97])
	by lists.oasis-open.org (Postfix) with QMQP
	id 2CC07983D9C; Fri, 14 Apr 2023 03:30:12 +0000 (UTC)
Mailing-List: contact virtio-dev-help@lists.oasis-open.org; run by ezmlm
List-ID: <virtio-dev.lists.oasis-open.org>
Sender: <virtio-dev@lists.oasis-open.org>
Precedence: bulk
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id 18B80986600
	for <virtio-dev@lists.oasis-open.org>; Fri, 14 Apr 2023 03:30:12 +0000 (UTC)
X-Virus-Scanned: amavisd-new at kavi.com
X-MC-Unique: h51KQ6IXOv2E8NfjcgqEyw-1
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1681443002; x=1684035002;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=88IqUGfaMgaxlxEftETcVgSp2ZTA7ooBQqyg02hPnAE=;
        b=J1JmAt6+uuDZTP+uJ7hSlRvyslxsYxygfyvjD1gKe3L3/2rrI2Kl69iI2IUZc90vor
         5m5N/PZhqhm+h7oR3L4x34yjyGj1Ob23n7tL74+UTW1ZkcNixjUiFa7pgHwvL1K0x1oL
         ZRApH4tcEOgCtZb4qhd4jhtNRVVlz4CPJXjYYmAKQVV7KMHkNqp47oF2CqnNrPbnXPUg
         aL9RypCg35/SPLpEI5RnuqFrdb+S9qfWeLHf9PZO4ovH409fcybb2/iat7sfJt4qIz2V
         xF+paIyKo3cTr20Qh3G05wCoTX3mhezG/jjaAnRt75+JHhN7qjTqF287DHGaV14AQDCl
         QxxQ==
X-Gm-Message-State: AAQBX9csYrVjN/D3jLcT2JWrPy6VILeK52mJyphPnIpXLPDqbIPVsQ30
	yP4aDBSG56y8BIjK9WmTtzbQihl86ks72hDs3/QqumOo5vzb9G/eemXtorVEq6QtKGUPfJEex3Z
	nNm+tonhiQfb506S5no3BN+owQH1CaOYrVdnfgzLh1UK7
X-Received: by 2002:a05:6830:1d88:b0:6a4:3176:feac with SMTP id y8-20020a0568301d8800b006a43176feacmr1081514oti.2.1681443002180;
        Thu, 13 Apr 2023 20:30:02 -0700 (PDT)
X-Google-Smtp-Source: AKy350aFfc02cFwgX40tkA89Kwp5KpsUfdNxzWkU3WJTZlF8U9NiZXRsBL5A5rrnefd9zjbn4iPaC86xIDQt6pb6G7c=
X-Received: by 2002:a05:6830:1d88:b0:6a4:3176:feac with SMTP id
 y8-20020a0568301d8800b006a43176feacmr1081504oti.2.1681443001950; Thu, 13 Apr
 2023 20:30:01 -0700 (PDT)
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
 <CACGkMEsYYQTMdhPy2oVoP=2B9jcK+OJ_TPHqdEsip_pjZvyiOA@mail.gmail.com> <PH0PR12MB5481EB1D036BCF7404CAA7FCDC999@PH0PR12MB5481.namprd12.prod.outlook.com>
In-Reply-To: <PH0PR12MB5481EB1D036BCF7404CAA7FCDC999@PH0PR12MB5481.namprd12.prod.outlook.com>
From: Jason Wang <jasowang@redhat.com>
Date: Fri, 14 Apr 2023 11:29:50 +0800
Message-ID: <CACGkMEusxum0m=wtHcECyK1KE6M6qs75QU7jXsAh-iU4psRLqw@mail.gmail.com>
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

On Fri, Apr 14, 2023 at 11:22=E2=80=AFAM Parav Pandit <parav@nvidia.com> wr=
ote:
>
>
>
> > From: Jason Wang <jasowang@redhat.com>
> > Sent: Thursday, April 13, 2023 11:18 PM
>
> > > >
> > > > It's a must for ABI and migration compatibility:
> > > >
> > > > 1) The offset is not necessarily a page boundary
> > > > 2) The length is not necessarily times of a PAGE_SIZE
> > > > 3) PAGE_SIZE varies among different archs
> > > > 4) Two vendors may have two different layout for the structure
> > >
> > > Migration compatibility check and device composition work will start =
for
> > regular PCI VF in virtio.
> > > Two vendors will had some level of programmability as well to make th=
is
> > happen.
> > > It is orthogonal topic.
> >
> > Actually not, having new blockers for live migration will complicate th=
e solution
> > in the future.
> >
> It is not a blocker, its just another flexible field that hw vendors will=
 align to a common way to configure.
>
> Just to make sure this is the BAR0 size, right?

We're discussing "if mediating 1.x device is a must" as I reply to
what you said:

"
Trapping non legacy accessing for 1.x doesn't make sense.
"

>
> > And 1) 2) 3) can happen even if we don't care about migration compatibi=
lity,
> > no?
>
> I guess one we have spec definition, it wont be a problem.

How can you assign a cap length 4K to a guest assuming 8K as page size?

Thanks


---------------------------------------------------------------------
To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org

