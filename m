Return-Path: <virtio-dev-return-13116-virtio-dev=archiver.kernel.org@lists.oasis-open.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from ws5-mx01.kavi.com (ws5-mx01.kavi.com [34.193.7.191])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E0087EB64DA
	for <virtio-dev@archiver.kernel.org>; Wed, 28 Jun 2023 05:37:58 +0000 (UTC)
Received: from lists.oasis-open.org (oasis.ws5.connectedcommunity.org [10.110.1.242])
	by ws5-mx01.kavi.com (Postfix) with ESMTP id 4263D41F2A
	for <virtio-dev@archiver.kernel.org>; Wed, 28 Jun 2023 05:37:58 +0000 (UTC)
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id 350C4986587
	for <virtio-dev@archiver.kernel.org>; Wed, 28 Jun 2023 05:37:58 +0000 (UTC)
Received: from host09.ws5.connectedcommunity.org (host09.ws5.connectedcommunity.org [10.110.1.97])
	by lists.oasis-open.org (Postfix) with QMQP
	id 2796298654C; Wed, 28 Jun 2023 05:37:58 +0000 (UTC)
Mailing-List: contact virtio-dev-help@lists.oasis-open.org; run by ezmlm
List-ID: <virtio-dev.lists.oasis-open.org>
Sender: <virtio-dev@lists.oasis-open.org>
Precedence: bulk
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id 10020986551
	for <virtio-dev@lists.oasis-open.org>; Wed, 28 Jun 2023 05:37:53 +0000 (UTC)
X-Virus-Scanned: amavisd-new at kavi.com
X-MC-Unique: gSL263i9Ojqeae5mFaOsvg-1
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687930667; x=1690522667;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=DVVnDMF4VJG/ExbkYBU0BS7273O+/77JugdBOrA3NAo=;
        b=Nk0w82qUfIVRNZfVfK2s93+CTgI8sTT1ZZHbHoXLXmROVCQ51l9SGcKuGdJTcTVf46
         mEhJq2BhqIs+pc2+eN6U5crOXbKKpQMsQDiX2jNHMKK7gAcca2YbyicB/TB5y07WZ1/Q
         C0mIsjBXoaZ/mpHSymTtandUHI48Eb90o4p+NV2M89aXk9b5vix6F4nPDOxi+0Ebc/s7
         UxKO8anDtbgqrRUQQ1BTKpxs1X3dmclAsaoBlRq+gB3JmEDb+djpdlyWaBxzM4xs9OVN
         /Ix8elOE05Yr8UyHKdasjmNjmDXnvSV0ln7qiAmoDcqmSj6hNp62uIa09K5jZj4m2U/4
         OUBw==
X-Gm-Message-State: AC+VfDwceQNJoxMTcXs9BLUh3oLXq+pw3YBpwYylpbbzTh3lXfakxJGI
	IKgs3ff4gtSWBabwCPYUOA0tkDJpPOpikAsGWyqtTld7aj5LZgM8qvUu0eJKSoPitP7EfIXogoc
	OdtaLzjSRkZyv9Umo9FbMb2aG5KkooZJqYipTqPB7qEBI
X-Received: by 2002:a2e:9e4f:0:b0:2b1:b4e9:4c3 with SMTP id g15-20020a2e9e4f000000b002b1b4e904c3mr23226093ljk.2.1687930667369;
        Tue, 27 Jun 2023 22:37:47 -0700 (PDT)
X-Google-Smtp-Source: ACHHUZ6zNeRyVdR0+DYjHLdtWZiu+RrqU9X8gM9KHmgiycs97Gmwc8j8wVpzkFv8v8q2jGDwqNwHARK7EVLQULjPqQQ=
X-Received: by 2002:a2e:9e4f:0:b0:2b1:b4e9:4c3 with SMTP id
 g15-20020a2e9e4f000000b002b1b4e904c3mr23226080ljk.2.1687930667060; Tue, 27
 Jun 2023 22:37:47 -0700 (PDT)
MIME-Version: 1.0
References: <20230627163549.40028-1-hengqi@linux.alibaba.com>
 <CACGkMEvFmAiWDp8w=ytin21Oi+PcTb1X3Eve7Kt2NVr_RkhgmA@mail.gmail.com> <PH0PR12MB54811123CFCDEFE3B48D4381DC24A@PH0PR12MB5481.namprd12.prod.outlook.com>
In-Reply-To: <PH0PR12MB54811123CFCDEFE3B48D4381DC24A@PH0PR12MB5481.namprd12.prod.outlook.com>
From: Jason Wang <jasowang@redhat.com>
Date: Wed, 28 Jun 2023 13:37:35 +0800
Message-ID: <CACGkMEtgomh1EGNLqhXQssRW02nnHkamxT5rV5eZZ9BZFH=uJA@mail.gmail.com>
To: Parav Pandit <parav@nvidia.com>
Cc: Heng Qi <hengqi@linux.alibaba.com>, 
	"virtio-comment@lists.oasis-open.org" <virtio-comment@lists.oasis-open.org>, 
	"virtio-dev@lists.oasis-open.org" <virtio-dev@lists.oasis-open.org>, "Michael S . Tsirkin" <mst@redhat.com>, 
	Yuri Benditovich <yuri.benditovich@daynix.com>, Xuan Zhuo <xuanzhuo@linux.alibaba.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Subject: [virtio-dev] Re: [PATCH v19] virtio-net: support inner header hash

On Wed, Jun 28, 2023 at 12:23=E2=80=AFPM Parav Pandit <parav@nvidia.com> wr=
ote:
>
>
> > From: Jason Wang <jasowang@redhat.com>
> > Sent: Tuesday, June 27, 2023 11:46 PM
> >
> > Having it in the config space, then a type agnostic provisioning throug=
h config
> > space + feature bits just works fine.
> >
> Provisioning is far simpler thing to do in device specific way than askin=
g device to store this value in onchip area which is rarely accessed.

Are you suggesting to not place any new fields in the config space?

struct virtio_net_config {
        u8 mac[6];
        le16 status;
        le16 max_virtqueue_pairs;
        le16 mtu;
        le32 speed;
        u8 duplex;
        u8 rss_max_key_size;
        le16 rss_max_indirection_table_length;
        le32 supported_hash_types;
};

Which of the above do you think can be accessed frequently and which
part of the spec says it must be stored in the onchip area?

Thanks

> There are many fields of many features for 1.4 are discussed including th=
is one. All of these capabilities just cannot be stored in config space.
>
> > If we move it only via cvq, we need device specific provisioning interf=
ace.


---------------------------------------------------------------------
To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org

