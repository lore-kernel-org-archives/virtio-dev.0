Return-Path: <virtio-dev-return-14174-virtio-dev=archiver.kernel.org@lists.oasis-open.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from ws5-mx01.kavi.com (ws5-mx01.kavi.com [34.193.7.191])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 752BFC3DA6E
	for <virtio-dev@archiver.kernel.org>; Wed, 20 Dec 2023 07:35:55 +0000 (UTC)
Received: from lists.oasis-open.org (oasis.ws5.connectedcommunity.org [10.110.1.242])
	by ws5-mx01.kavi.com (Postfix) with ESMTP id B1482217AA
	for <virtio-dev@archiver.kernel.org>; Wed, 20 Dec 2023 07:35:54 +0000 (UTC)
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id 5FA9798655D
	for <virtio-dev@archiver.kernel.org>; Wed, 20 Dec 2023 07:35:54 +0000 (UTC)
Received: from host09.ws5.connectedcommunity.org (host09.ws5.connectedcommunity.org [10.110.1.97])
	by lists.oasis-open.org (Postfix) with QMQP
	id 4424F983F74; Wed, 20 Dec 2023 07:35:54 +0000 (UTC)
Mailing-List: contact virtio-dev-help@lists.oasis-open.org; run by ezmlm
List-ID: <virtio-dev.lists.oasis-open.org>
Sender: <virtio-dev@lists.oasis-open.org>
Precedence: bulk
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id 32DB4986542
	for <virtio-dev@lists.oasis-open.org>; Wed, 20 Dec 2023 07:35:54 +0000 (UTC)
X-Virus-Scanned: amavisd-new at kavi.com
X-MC-Unique: PXLPUF8rO1K_l1YBdHDgDQ-1
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1703057750; x=1703662550;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=BYX3hqf4XPqNEpmhUP1POLqIv1b0VhoIatzRuCinX4s=;
        b=QLt0c0nw5mOp1bHPg0uYi0shp7VNNDLE11zq/hzjCA+LifMjLOfascH+zOZl8Yi5Dg
         pxKfRloCZcpbsSGZElSuWiFXhptbN9+ZT3/iHtitwUFyXzC4F5Lf2hVEipBc42pBu/TU
         BMPPFLCpEsoFRmhCMnTy82LuDTRoV0HcfyoCzznQ7tOCEyD4k9uDziFHDuT+TVqjw3KI
         ydEEKIcZWEjiutJX5PQ3f/L1ehWRSSJWwYm8QJR8YM/1rkW3v3WiQAIwLco/1jK+idwC
         5JgxqnEx7sblJ0h5nRF+4Lpm5b+YP3+d4CYf5xQdycO4+CbF5T8f/8o46161KzCHZRcB
         k3LA==
X-Gm-Message-State: AOJu0Yyl4EqZfFAlB8cqg3KCWycIoixl79mxtTpN4qlQld9M6soy+YHz
	ZeKDgU1WXf3SL+Kuf73kB5lC/x0QuAyE79z0VJGhLIshrSE0Lg3+9OV8T9nWVEvhJdE60U+iV51
	q7Y4HYVZ0rbh6xv0XdNhRYwPJBR5T
X-Received: by 2002:a05:600c:16d4:b0:40c:2cab:3567 with SMTP id l20-20020a05600c16d400b0040c2cab3567mr9634322wmn.122.1703057750028;
        Tue, 19 Dec 2023 23:35:50 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHLWO0cfx6t5BJzOSfaT8ry2NlzRXTGawIfd4NfpghViTVMWbZLeW3X+j/VY1iv38j8vsCv7w==
X-Received: by 2002:a05:600c:16d4:b0:40c:2cab:3567 with SMTP id l20-20020a05600c16d400b0040c2cab3567mr9634316wmn.122.1703057749659;
        Tue, 19 Dec 2023 23:35:49 -0800 (PST)
Date: Wed, 20 Dec 2023 02:35:46 -0500
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Heng Qi <hengqi@linux.alibaba.com>
Cc: Jason Wang <jasowang@redhat.com>,
	"virtio-comment@lists.oasis-open.org" <virtio-comment@lists.oasis-open.org>,
	Yuri Benditovich <yuri.benditovich@daynix.com>,
	Xuan Zhuo <xuanzhuo@linux.alibaba.com>,
	"virtio-dev@lists.oasis-open.org" <virtio-dev@lists.oasis-open.org>
Message-ID: <20231220020428-mutt-send-email-mst@kernel.org>
References: <20231212032713-mutt-send-email-mst@kernel.org>
 <bfd25f86-4292-45d2-a7a2-fe61bde0edb4@linux.alibaba.com>
 <b739d275-3664-4509-8a91-f19690719475@linux.alibaba.com>
 <fafa078b-14f5-460d-b03e-122afb9156ba@linux.alibaba.com>
 <CACGkMEuCb13=-b1yMYi3NOehL+6eNWjWsmBHfcYho1w0HwpVBA@mail.gmail.com>
 <6d9353f7-2899-4ba9-8aef-2431c9362207@linux.alibaba.com>
 <CACGkMEsh9h_syGag48DL9rSSH2Yp4Ht-ES4gA-5rv16Lih_tJw@mail.gmail.com>
 <df90d58d-7e4e-44d7-8896-5fc5b131c164@linux.alibaba.com>
 <CACGkMEsxsLP=hnybYi2fiKXFq1U1zo+EuKnzfnbT3K_Wcrug5Q@mail.gmail.com>
 <68b0d00b-8b3b-4bd4-9e7c-c3b811dafd8c@linux.alibaba.com>
MIME-Version: 1.0
In-Reply-To: <68b0d00b-8b3b-4bd4-9e7c-c3b811dafd8c@linux.alibaba.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Subject: Re: [virtio-dev] Re: [virtio-comment] Re: [PATCH v5] virtio-net:
 device does not deliver partially checksummed packet and may validate the
 checksum

On Wed, Dec 20, 2023 at 02:30:01PM +0800, Heng Qi wrote:
> But why are we discussing this?

I think basically at this point everyone is confused about what
the feature does. right now we have packets
with 
#define VIRTIO_NET_HDR_F_NEEDS_CSUM     1       -> partial
#define VIRTIO_NET_HDR_F_DATA_VALID     2       -> unnecessary
and packets without either 			-> none

if both 1 and 2 are set then linux uses VIRTIO_NET_HDR_F_NEEDS_CSUM but
I am not sure it's not a mistake. Maybe it does not matter.

What does this new thing do? So far all we have is "XDP will turn it on"
which is not really sufficient. I assumed it somehow replaces
partial with complete. That would make sense for many reasons,
for example the checksum fields in the header can be reused
for other purposes. But maybe not?


-- 
MST


---------------------------------------------------------------------
To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org

