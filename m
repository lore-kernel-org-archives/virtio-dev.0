Return-Path: <virtio-dev-return-13483-virtio-dev=archiver.kernel.org@lists.oasis-open.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from ws5-mx01.kavi.com (ws5-mx01.kavi.com [34.193.7.191])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9CAC6EB64DD
	for <virtio-dev@archiver.kernel.org>; Tue,  8 Aug 2023 02:30:43 +0000 (UTC)
Received: from lists.oasis-open.org (oasis.ws5.connectedcommunity.org [10.110.1.242])
	by ws5-mx01.kavi.com (Postfix) with ESMTP id 1537E66DCA
	for <virtio-dev@archiver.kernel.org>; Tue,  8 Aug 2023 02:30:43 +0000 (UTC)
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id 0C88E986553
	for <virtio-dev@archiver.kernel.org>; Tue,  8 Aug 2023 02:30:43 +0000 (UTC)
Received: from host09.ws5.connectedcommunity.org (host09.ws5.connectedcommunity.org [10.110.1.97])
	by lists.oasis-open.org (Postfix) with QMQP
	id F2EAC986460; Tue,  8 Aug 2023 02:30:42 +0000 (UTC)
Mailing-List: contact virtio-dev-help@lists.oasis-open.org; run by ezmlm
List-ID: <virtio-dev.lists.oasis-open.org>
Sender: <virtio-dev@lists.oasis-open.org>
Precedence: bulk
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id DE14C986471
	for <virtio-dev@lists.oasis-open.org>; Tue,  8 Aug 2023 02:30:42 +0000 (UTC)
X-Virus-Scanned: amavisd-new at kavi.com
X-MC-Unique: M-FMOZ6sOWOpKzXvSvwihA-1
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691461837; x=1692066637;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=xaNspgpLdRo8ZigJihjxrI5TLAylk17gtHYl0h+dC3c=;
        b=iZ8T7TBqKs7vWvJ483aosbcqCAWOeOi8Arn5Go4SO96IE6CHsMBDgk25jx0Rt0b4ug
         LL8kiK+gd6nkTjF6OXMVhbSSqlIw8ta4YoBvwzsS9ElFQT01MqTL2hpMaiWQpaQubBV/
         HFdcgFZWqmm4SbvSgo2Cws+NZDMWIMBzL+vfLWnVjj3riJKv4om4tYpJ6Ba1OyxbOUMX
         A02Pr9VUSJn3OC15kmHCgXfLUwDC92xxcCFvTT0rabcqu2zoNM8d2HZxFS9XyfP3LwSl
         qcogP36+oqCHpj7aeneevEnRvS0PdP1RKTi9wJTxvpzHEMfQlsVc4opdg1NTNQ4jC9Gl
         NyoQ==
X-Gm-Message-State: AOJu0Yw30dQmFLqUSBzRbGpwobjkH66KYhF0WgHkLT0IubXoip6i4uyW
	oao5j2OV37aZsDlBI5I2zoZHJJcGHnUsIIFztLyzAeAqkK/YaJhxbNQ+b8qA1xHtZmOOtOpf4P+
	HuIAse30hKMihvp+uzU7Xj0IDjRqII7ubx9F//ddO7iIN
X-Received: by 2002:a2e:7004:0:b0:2b9:d19c:2ad9 with SMTP id l4-20020a2e7004000000b002b9d19c2ad9mr7147127ljc.35.1691461837414;
        Mon, 07 Aug 2023 19:30:37 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFyqEOgZp2TPDZ48OmwkeoI8HMoAGbxtWMkP5nMCwuCvmmJnWl+aFyhm4bAbz+DGleWMg14PSbXHEv0T6Uxjfk=
X-Received: by 2002:a2e:7004:0:b0:2b9:d19c:2ad9 with SMTP id
 l4-20020a2e7004000000b002b9d19c2ad9mr7147119ljc.35.1691461837133; Mon, 07 Aug
 2023 19:30:37 -0700 (PDT)
MIME-Version: 1.0
References: <20230803083150.46745-1-xuanzhuo@linux.alibaba.com>
 <20230803054333-mutt-send-email-mst@kernel.org> <CACGkMEsdM+bi_scj6kgo7FrRDNGwF-=37bT8tOC6DXg9fTuNRw@mail.gmail.com>
 <PH0PR12MB5481EBFEB23938CDC765DA54DC09A@PH0PR12MB5481.namprd12.prod.outlook.com>
In-Reply-To: <PH0PR12MB5481EBFEB23938CDC765DA54DC09A@PH0PR12MB5481.namprd12.prod.outlook.com>
From: Jason Wang <jasowang@redhat.com>
Date: Tue, 8 Aug 2023 10:30:26 +0800
Message-ID: <CACGkMEvKoZ21tJEDn-hgEzjDcixbxiyejtm_=RD7zebaCnuxxQ@mail.gmail.com>
To: Parav Pandit <parav@nvidia.com>
Cc: "Michael S. Tsirkin" <mst@redhat.com>, Xuan Zhuo <xuanzhuo@linux.alibaba.com>, 
	"virtio-dev@lists.oasis-open.org" <virtio-dev@lists.oasis-open.org>, 
	"virtio-comment@lists.oasis-open.org" <virtio-comment@lists.oasis-open.org>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Subject: [virtio-dev] Re: [RFC] virtio-net: support access and control the member devices

On Fri, Aug 4, 2023 at 12:05=E2=80=AFPM Parav Pandit <parav@nvidia.com> wro=
te:
>
>
>
> > From: Jason Wang <jasowang@redhat.com>
> > Sent: Friday, August 4, 2023 9:02 AM
>
> > I think we probably need some split here.
> >
> > E.g the fields belonging to configuration space might go with a more ge=
neral
> > interface like admin command/queue.
> >
> > The net specific ones need to go through a net specific interface.
> > (cvq of PF or reps)
>
> I don=E2=80=99t see the need of such split.
> Why do you think that?

It's simply because part of the fields belong to config space.

Thanks


---------------------------------------------------------------------
To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org

