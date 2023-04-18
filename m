Return-Path: <virtio-dev-return-12265-virtio-dev=archiver.kernel.org@lists.oasis-open.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from ws5-mx01.kavi.com (ws5-mx01.kavi.com [34.193.7.191])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 44A91C77B72
	for <virtio-dev@archiver.kernel.org>; Tue, 18 Apr 2023 00:36:49 +0000 (UTC)
Received: from lists.oasis-open.org (oasis.ws5.connectedcommunity.org [10.110.1.242])
	by ws5-mx01.kavi.com (Postfix) with ESMTP id 5846E19092D
	for <virtio-dev@archiver.kernel.org>; Tue, 18 Apr 2023 00:36:47 +0000 (UTC)
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id 365099863FC
	for <virtio-dev@archiver.kernel.org>; Tue, 18 Apr 2023 00:36:47 +0000 (UTC)
Received: from host09.ws5.connectedcommunity.org (host09.ws5.connectedcommunity.org [10.110.1.97])
	by lists.oasis-open.org (Postfix) with QMQP
	id 2089E9863D9; Tue, 18 Apr 2023 00:36:47 +0000 (UTC)
Mailing-List: contact virtio-dev-help@lists.oasis-open.org; run by ezmlm
List-ID: <virtio-dev.lists.oasis-open.org>
Sender: <virtio-dev@lists.oasis-open.org>
Precedence: bulk
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id DBE5B986641
	for <virtio-dev@lists.oasis-open.org>; Tue, 18 Apr 2023 00:36:46 +0000 (UTC)
X-Virus-Scanned: amavisd-new at kavi.com
X-MC-Unique: KL7TCtD5ObGw135tlDyBMQ-1
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1681778201; x=1684370201;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=bJQmC4yXC11D8UkeYkiwL9O894hOfu6xgcPmy3/Qaxk=;
        b=fZPAbPndEjPdK83xnUbXy8wuhrfQ1eaO43VJKLpexPVuchKiyzGalIK/jyQbpUC7WZ
         iZk23R+Kqu5M+OOUQrdrmAlfxspE5dyq5hG6WKSV8yMt1bdUUvUzwPQk1wefMaLqvk0k
         1n12sWth/X84N0RJOOVEJ3A/1k4OB9sdIj35/z1GrcWQqViUkswESLy5ct+vZtCs524d
         4Iltg88k2rnV48S8EfjAxj2noen9B0GL9dlCh7d6OBlyB/NYiKYeUJF6xw2GtExN/CZi
         exX2FUV2XS7fN7EGhrUVhDWOrWWfC0Gl7cmKCBp38+pMxhEhkPWbxNms1iqYkNDW6kcv
         OYuA==
X-Gm-Message-State: AAQBX9ejoJ5+mOOmPUqhW5MTjIbSiwRAm2W8ChXfIC3+F5+ykzUGHXYv
	CESgNewHdYcT+rI3wnEOg4tlOKr3VWyIcmWAd7v8z0k/D/NSixAcwJS+/F+H1tNsXp373GlYF3F
	7qkfJ1kYXQaavrU2lsmkKfeVWvfvxocx4nvFNgr4uQHmF
X-Received: by 2002:aca:a843:0:b0:38d:f9f6:2519 with SMTP id r64-20020acaa843000000b0038df9f62519mr111695oie.3.1681778201657;
        Mon, 17 Apr 2023 17:36:41 -0700 (PDT)
X-Google-Smtp-Source: AKy350ZOi0tihwwRp6jT4xReGXEpgBv7VwWuJOw97RuSjBgjLiLRiDXeAsJKTsRd6UE2+seqqycEtuqwb8FnCj7rcXM=
X-Received: by 2002:aca:a843:0:b0:38d:f9f6:2519 with SMTP id
 r64-20020acaa843000000b0038df9f62519mr111684oie.3.1681778201418; Mon, 17 Apr
 2023 17:36:41 -0700 (PDT)
MIME-Version: 1.0
References: <a74d3107-d38c-df15-e2ff-f848635f24bd@nvidia.com>
 <CACGkMEt+bGN7UYEopXPj0+deAnYm1VUNp05VvGHcJnkd8LzbGg@mail.gmail.com>
 <20230413130326-mutt-send-email-mst@kernel.org> <PH0PR12MB54819A5D8FCEC6375D80897DDC989@PH0PR12MB5481.namprd12.prod.outlook.com>
 <CACGkMEvSSXyXQnRs=OiaSJnSEYHP83chL6-B5ZPCGx6TeW9W5Q@mail.gmail.com>
 <PH0PR12MB548135CF5268D979A6D8EDE8DC999@PH0PR12MB5481.namprd12.prod.outlook.com>
 <CACGkMEsHtC99kTTa0TrfeJuhV+F7e-WF7XRgbLJkCBQeAxW8pA@mail.gmail.com>
 <PH0PR12MB5481C29561D5E48BA5D8AEEEDC999@PH0PR12MB5481.namprd12.prod.outlook.com>
 <CACGkMEseO=4xDA+pH2x=CaJ6XyzHEx1ZFO-+uevJH50kLeSWhA@mail.gmail.com>
 <PH0PR12MB5481FFC95F54AD048927FF12DC9C9@PH0PR12MB5481.namprd12.prod.outlook.com>
 <20230417162618-mutt-send-email-mst@kernel.org> <PH0PR12MB5481710854882449008F28BDDC9C9@PH0PR12MB5481.namprd12.prod.outlook.com>
In-Reply-To: <PH0PR12MB5481710854882449008F28BDDC9C9@PH0PR12MB5481.namprd12.prod.outlook.com>
From: Jason Wang <jasowang@redhat.com>
Date: Tue, 18 Apr 2023 08:36:30 +0800
Message-ID: <CACGkMEvPv7eH3+cggcCVZvRCqkNCh_CX+6azNJtdJUDxjjAjwg@mail.gmail.com>
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

On Tue, Apr 18, 2023 at 4:29=E2=80=AFAM Parav Pandit <parav@nvidia.com> wro=
te:
>
>
> > From: Michael S. Tsirkin <mst@redhat.com>
> > Sent: Monday, April 17, 2023 4:27 PM
> > On Mon, Apr 17, 2023 at 05:23:30PM +0000, Parav Pandit wrote:
> > > > Things might be simplified if we use separate queues for admin,
> > > > transport and legacy.
> > > >
> > > Do you mean say we have three AQs, AQ_1, AQ_2, and AQ_3;
> > > AQ_1 of the PF used by admin work as SIOV device create, SRIOV MSIX
> > configuration.
> > > AQ_2 of the PF used for transporting legacy config access of the PCI
> > > VF
> > > AQ_3 of the PF for some transport work.
> > >
> > > If yes, sounds find to me.
> >
> > Latest proposal simply leaves the split between AQs up to the driver.
> > Seems the most flexible.
> Yes. It is. Different opcode range and multiple AQs enable to do so.

Right, so it would be some facility that makes the transport commands
of modern and legacy are mutually exclusive.

Thanks

>
> This publicly archived list offers a means to provide input to the
> OASIS Virtual I/O Device (VIRTIO) TC.
>
> In order to verify user consent to the Feedback License terms and
> to minimize spam in the list archive, subscription is required
> before posting.
>
> Subscribe: virtio-comment-subscribe@lists.oasis-open.org
> Unsubscribe: virtio-comment-unsubscribe@lists.oasis-open.org
> List help: virtio-comment-help@lists.oasis-open.org
> List archive: https://lists.oasis-open.org/archives/virtio-comment/
> Feedback License: https://www.oasis-open.org/who/ipr/feedback_license.pdf
> List Guidelines: https://www.oasis-open.org/policies-guidelines/mailing-l=
ists
> Committee: https://www.oasis-open.org/committees/virtio/
> Join OASIS: https://www.oasis-open.org/join/
>


---------------------------------------------------------------------
To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org

