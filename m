Return-Path: <virtio-dev-return-13426-virtio-dev=archiver.kernel.org@lists.oasis-open.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from ws5-mx01.kavi.com (ws5-mx01.kavi.com [34.193.7.191])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 10CE0C001DC
	for <virtio-dev@archiver.kernel.org>; Mon, 31 Jul 2023 09:13:21 +0000 (UTC)
Received: from lists.oasis-open.org (oasis.ws5.connectedcommunity.org [10.110.1.242])
	by ws5-mx01.kavi.com (Postfix) with ESMTP id 6BE805498
	for <virtio-dev@archiver.kernel.org>; Mon, 31 Jul 2023 09:13:21 +0000 (UTC)
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id 639D598650A
	for <virtio-dev@archiver.kernel.org>; Mon, 31 Jul 2023 09:13:21 +0000 (UTC)
Received: from host09.ws5.connectedcommunity.org (host09.ws5.connectedcommunity.org [10.110.1.97])
	by lists.oasis-open.org (Postfix) with QMQP
	id 5745798637C; Mon, 31 Jul 2023 09:13:21 +0000 (UTC)
Mailing-List: contact virtio-dev-help@lists.oasis-open.org; run by ezmlm
List-ID: <virtio-dev.lists.oasis-open.org>
Sender: <virtio-dev@lists.oasis-open.org>
Precedence: bulk
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id 420C898637E
	for <virtio-dev@lists.oasis-open.org>; Mon, 31 Jul 2023 09:13:16 +0000 (UTC)
X-Virus-Scanned: amavisd-new at kavi.com
X-MC-Unique: _Ab4TlGYNQamaI1NtXD7cw-1
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690794793; x=1691399593;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=dpaIMjB5xKrspjz9EZT5Go05akNFwr+J4PZNOBaKhEg=;
        b=hZgnoD5oWvPCRwKUSCr8d0O6Wv6X8CxPBioYv9GiRnW3YtM4BEAirnSCwos7i5uFox
         Qgf15ijDcFf7LZwZOLKoZunwOk4SB0FO9WVm+uRJefN5V64Adx9NcMDDw9CVk7zN+9Fa
         Mu06xUjLpR2RQFlUGN2nqBP/x71twIOScEPnlKrpH7BPvDPc+t3Z/UnIsKZXa4hg7PfU
         5AduOP0GVgFxCtngpT9nOm7WbR/wzuQQKqgaWFTx9448r1wpSfOCd/s6VosGufzu38sm
         kFEeYnabEb8FO61ET0RjU+1F8rm2282PuCQv92ZlTP0zzL6qQ80SoqYNZDvjwZC6DwWt
         GOKA==
X-Gm-Message-State: ABy/qLZkYsNko+RgVKmLOJgm24HMcNyNNz77xM3Mg/CgFzYaoFzjKsUQ
	8Sop53fL/iZ4nDBt0fRysn/uad9W1Ybp5wlxe0miAFCnez5yE5oXv9dTsw6RGC/U0PTVryiwrwK
	HasjUKDPoxxMsTmHKi46lKNrhtk0n
X-Received: by 2002:a05:6512:718:b0:4fd:d538:b97b with SMTP id b24-20020a056512071800b004fdd538b97bmr4715641lfs.29.1690794792841;
        Mon, 31 Jul 2023 02:13:12 -0700 (PDT)
X-Google-Smtp-Source: APBJJlHLfcCf0ZyPvA4HmBJEZEd2OTZz+nAHZqini7MnjX7tsuRVJKYaa4gFlnoQzVjQ+hi9ruqX2w==
X-Received: by 2002:a05:6512:718:b0:4fd:d538:b97b with SMTP id b24-20020a056512071800b004fdd538b97bmr4715626lfs.29.1690794792462;
        Mon, 31 Jul 2023 02:13:12 -0700 (PDT)
Date: Mon, 31 Jul 2023 05:13:09 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Parav Pandit <parav@nvidia.com>
Cc: Xuan Zhuo <xuanzhuo@linux.alibaba.com>,
	"virtio-dev@lists.oasis-open.org" <virtio-dev@lists.oasis-open.org>,
	"jasowang@redhat.com" <jasowang@redhat.com>,
	"virtio-comment@lists.oasis-open.org" <virtio-comment@lists.oasis-open.org>
Message-ID: <20230731051230-mutt-send-email-mst@kernel.org>
References: <20230726081229.55947-1-xuanzhuo@linux.alibaba.com>
 <20230726070801-mutt-send-email-mst@kernel.org>
 <1690422490.8491526-1-xuanzhuo@linux.alibaba.com>
 <PH0PR12MB548149ED4C687913EDA3EED9DC05A@PH0PR12MB5481.namprd12.prod.outlook.com>
 <1690782610.3048255-3-xuanzhuo@linux.alibaba.com>
 <PH0PR12MB5481F2D5FA4BA77DD0A08192DC05A@PH0PR12MB5481.namprd12.prod.outlook.com>
MIME-Version: 1.0
In-Reply-To: <PH0PR12MB5481F2D5FA4BA77DD0A08192DC05A@PH0PR12MB5481.namprd12.prod.outlook.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Subject: [virtio-dev] Re: RE: [PATCH v13] virtio-net: support device stats

On Mon, Jul 31, 2023 at 06:19:14AM +0000, Parav Pandit wrote:
> 
> 
> > From: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
> > Sent: Monday, July 31, 2023 11:20 AM
> > I will keep pushing this, if your proposals affect this, I will fix it in a furture
> > version.
> 
> We need the bitmap indicating which counters supported which are not.
> And those to be queried via dma interface.
> So this counters proposal has direct dependency on dma interface to work first.

my hope is we can switch all of config space to dma.

-- 
MST


---------------------------------------------------------------------
To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org

