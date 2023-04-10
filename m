Return-Path: <virtio-dev-return-12074-virtio-dev=archiver.kernel.org@lists.oasis-open.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from ws5-mx01.kavi.com (ws5-mx01.kavi.com [34.193.7.191])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B45A9C77B6E
	for <virtio-dev@archiver.kernel.org>; Mon, 10 Apr 2023 01:52:16 +0000 (UTC)
Received: from lists.oasis-open.org (oasis.ws5.connectedcommunity.org [10.110.1.242])
	by ws5-mx01.kavi.com (Postfix) with ESMTP id 181377C24A
	for <virtio-dev@archiver.kernel.org>; Mon, 10 Apr 2023 01:52:16 +0000 (UTC)
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id 0C68D986371
	for <virtio-dev@archiver.kernel.org>; Mon, 10 Apr 2023 01:52:16 +0000 (UTC)
Received: from host09.ws5.connectedcommunity.org (host09.ws5.connectedcommunity.org [10.110.1.97])
	by lists.oasis-open.org (Postfix) with QMQP
	id 014169843C6; Mon, 10 Apr 2023 01:52:16 +0000 (UTC)
Mailing-List: contact virtio-dev-help@lists.oasis-open.org; run by ezmlm
List-ID: <virtio-dev.lists.oasis-open.org>
Sender: <virtio-dev@lists.oasis-open.org>
Precedence: bulk
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id E63BB9862A5
	for <virtio-dev@lists.oasis-open.org>; Mon, 10 Apr 2023 01:52:15 +0000 (UTC)
X-Virus-Scanned: amavisd-new at kavi.com
X-MC-Unique: 4c0zXpxhMtyxCkAMI1a7Yg-1
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1681091532; x=1683683532;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=gylN7Z2jUkvVQrFHlw811JdEszXdnO/dnVUJcvJzV+E=;
        b=Fy7LSF74fJn4dzC/m76pCRBiPN6c8b8KJUM49OfmcceOQzEJcYhRcMSzGsB4ELpQzf
         94d0CIM4K/lesyGKT8q3xiA7CVZJtfPz7h8x8rwtmNQp0TAcl60ILr20sxcdNncuYVe7
         jW6hGdUcLXtIkcx3kBtINRcjUF27hpYm2fkltFXX+tx4R6tpsi2+/Zm5wJ6E2X6LUtEw
         mpO1aa28ViX6C/QXqPwKkYoobkSxHX3dARlwRtn/oIlzKmleHeNKRHiz+H8VE0rG4uxe
         ceqqAR4kFzwsk8SqHJWq+nIywgsnh9lKgyDv9j0tFvFz8IGpU7J0jUXiNk68f1iQSIRf
         0lzw==
X-Gm-Message-State: AAQBX9eySxiPtrwjA6iaM8K0ipBHcz/5tjdumTONsxdCvUtlWYymAMT4
	djdBJUWi/Vvw+20GO46j2M16+EnubE+oQ3kbWk5m4igN/A8x7TKZjwWvaJmm6Q7172KQRvinbHS
	SG1hhBQoeMI1KTc6UsV7qo5ZWS5ITnBlHImUBZyCwImvU
X-Received: by 2002:a05:6871:b2c:b0:184:5497:53e6 with SMTP id fq44-20020a0568710b2c00b00184549753e6mr141469oab.3.1681091532754;
        Sun, 09 Apr 2023 18:52:12 -0700 (PDT)
X-Google-Smtp-Source: AKy350YQOVxMqKaYgTeBVqk69VtDBeUcfKeQ3NkZ3mcW4RxQUaVL8nnctuI5udUHwRyq9GuQA/kuQIB9y0UDPqdrhL4=
X-Received: by 2002:a05:6871:b2c:b0:184:5497:53e6 with SMTP id
 fq44-20020a0568710b2c00b00184549753e6mr141464oab.3.1681091532558; Sun, 09 Apr
 2023 18:52:12 -0700 (PDT)
MIME-Version: 1.0
References: <20230403110320-mutt-send-email-mst@kernel.org>
 <PH0PR12MB5481EC65708410304D9C1EA3DC929@PH0PR12MB5481.namprd12.prod.outlook.com>
 <20230403111735-mutt-send-email-mst@kernel.org> <PH0PR12MB54813E4193BC32775BDB2019DC929@PH0PR12MB5481.namprd12.prod.outlook.com>
 <20230403130950-mutt-send-email-mst@kernel.org> <24e5437e-d6bd-d65c-9ec2-699277a113a3@nvidia.com>
 <20230403135446-mutt-send-email-mst@kernel.org> <PH0PR12MB54815AFE1FE7E1D2AAABBAF4DC929@PH0PR12MB5481.namprd12.prod.outlook.com>
 <20230403163730-mutt-send-email-mst@kernel.org> <25d15176-042a-f579-0b59-d08f7eb7eafb@nvidia.com>
 <20230407051748-mutt-send-email-mst@kernel.org>
In-Reply-To: <20230407051748-mutt-send-email-mst@kernel.org>
From: Jason Wang <jasowang@redhat.com>
Date: Mon, 10 Apr 2023 09:52:01 +0800
Message-ID: <CACGkMEsMiw31isTvk+c96m-=gfwxaLoUmSMU-Jws1ZL=Ee=nHg@mail.gmail.com>
To: "Michael S. Tsirkin" <mst@redhat.com>
Cc: Parav Pandit <parav@nvidia.com>, 
	"virtio-dev@lists.oasis-open.org" <virtio-dev@lists.oasis-open.org>, "cohuck@redhat.com" <cohuck@redhat.com>, 
	"virtio-comment@lists.oasis-open.org" <virtio-comment@lists.oasis-open.org>, Shahaf Shuler <shahafs@nvidia.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Subject: [virtio-dev] Re: [virtio-comment] Re: [PATCH 00/11] Introduce transitional mmr pci device

On Fri, Apr 7, 2023 at 5:35=E2=80=AFPM Michael S. Tsirkin <mst@redhat.com> =
wrote:
>
> On Mon, Apr 03, 2023 at 06:00:13PM -0400, Parav Pandit wrote:
> >
> >
> > On 4/3/2023 5:04 PM, Michael S. Tsirkin wrote:
> > > On Mon, Apr 03, 2023 at 08:25:02PM +0000, Parav Pandit wrote:
> > > >
> > > > > From: Michael S. Tsirkin <mst@redhat.com>
> > > > > Sent: Monday, April 3, 2023 2:02 PM
> > > >

[...]

> >
> > tvq specific for legacy register access make sense.
> > Some generic tvq is abstract and dont see any relation here.
> >
> > So better to name it as legacy_reg_transport_vq (lrt_vq).
>
> Again this assumes tvq will be rewritten on top of AQ.
> I guess legacy can then become a new type of AQ command?
>
> And maybe you want a memory mapped register for AQ commands? I know
> Jason really wanted that.
>

That's exactly why we decouple the commands from a specific transport
(queue or register). It allows sufficient flexibility.

Thanks


---------------------------------------------------------------------
To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org

