Return-Path: <virtio-dev-return-14003-virtio-dev=archiver.kernel.org@lists.oasis-open.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from ws5-mx01.kavi.com (ws5-mx01.kavi.com [34.193.7.191])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4A1F7CDB46E
	for <virtio-dev@archiver.kernel.org>; Thu, 12 Oct 2023 11:13:43 +0000 (UTC)
Received: from lists.oasis-open.org (oasis.ws5.connectedcommunity.org [10.110.1.242])
	by ws5-mx01.kavi.com (Postfix) with ESMTP id 96FCD790ED
	for <virtio-dev@archiver.kernel.org>; Thu, 12 Oct 2023 11:13:42 +0000 (UTC)
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id 85A0698683A
	for <virtio-dev@archiver.kernel.org>; Thu, 12 Oct 2023 11:13:42 +0000 (UTC)
Received: from host09.ws5.connectedcommunity.org (host09.ws5.connectedcommunity.org [10.110.1.97])
	by lists.oasis-open.org (Postfix) with QMQP
	id 77D8B986474; Thu, 12 Oct 2023 11:13:42 +0000 (UTC)
Mailing-List: contact virtio-dev-help@lists.oasis-open.org; run by ezmlm
List-ID: <virtio-dev.lists.oasis-open.org>
Sender: <virtio-dev@lists.oasis-open.org>
Precedence: bulk
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id 6ABD298660E
	for <virtio-dev@lists.oasis-open.org>; Thu, 12 Oct 2023 11:13:42 +0000 (UTC)
X-Virus-Scanned: amavisd-new at kavi.com
X-MC-Unique: Ox6rcjVeMm2Q7Niy8Wv3uQ-1
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697109214; x=1697714014;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=2ksyvTvHNyca4OE3u2786n78HW3KmwBdKmFCP6SHYyI=;
        b=HH/9fo2iG4klmGFa0h8C4ic1OK/AzeUzOF0CTv5fv0TTWcyL+f7AHXylwqOfZMv9RG
         kyg7uZ/XeZI4oa/jdUB15G9uMRyOY/RErTxl/oa47N41H6jCXLbZEk5j5mwb75Fhw7n3
         De1Q2txYAmTo/yKvr67Vk0hDDvNQTRL5Z9EI7geuCF40ulC15xlgnYSDRfg3orbYgttD
         iq1h7TrvmM5+1klmdqHTygkTmTYXo9Xu2v91Xcv4deu0Ofm6p4jY4hrW/FghtKi6ShwS
         d6EgigSV361pVRBtPCw9CmGxWRQB/TZQziYHjwaF4SJCCsuLV8Bdi/5HGjbxiY23MCxn
         UarA==
X-Gm-Message-State: AOJu0YxdQ6Sn6WedxR7od4k4RbLryHbSXOod2V5gasyMGiMNRGa5e64y
	Ie/jhcbaDmbFZyLcMd1z68ZRX0oA9Y/m1+5i0Y/ZiXc5oyV9dwcU46DkJC/vzsujougmKXLmxq8
	UiFsvTbuXMOIkM9aRfUzn2Ia2L1N+
X-Received: by 2002:a5d:4f85:0:b0:31a:ea9a:b602 with SMTP id d5-20020a5d4f85000000b0031aea9ab602mr23679844wru.1.1697109214651;
        Thu, 12 Oct 2023 04:13:34 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGtvxw9xzrYsRWkpkZ7UwZm2gOoroTaKTCAWF2fNCZAKK2qJgjdOZUsbDyoIJz/izWi5ed0rA==
X-Received: by 2002:a5d:4f85:0:b0:31a:ea9a:b602 with SMTP id d5-20020a5d4f85000000b0031aea9ab602mr23679828wru.1.1697109214348;
        Thu, 12 Oct 2023 04:13:34 -0700 (PDT)
Date: Thu, 12 Oct 2023 07:13:30 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: "Zhu, Lingshan" <lingshan.zhu@intel.com>
Cc: Parav Pandit <parav@nvidia.com>, Cornelia Huck <cohuck@redhat.com>,
	Jason Wang <jasowang@redhat.com>,
	"eperezma@redhat.com" <eperezma@redhat.com>,
	Stefan Hajnoczi <stefanha@redhat.com>,
	"virtio-comment@lists.oasis-open.org" <virtio-comment@lists.oasis-open.org>,
	"virtio-dev@lists.oasis-open.org" <virtio-dev@lists.oasis-open.org>
Message-ID: <20231012071241-mutt-send-email-mst@kernel.org>
References: <PH0PR12MB5481C57B255B0D5EA6FB109DDCC3A@PH0PR12MB5481.namprd12.prod.outlook.com>
 <ddbd47c8-6985-2d08-bf98-0e7516f0c3c4@intel.com>
 <20230926064201-mutt-send-email-mst@kernel.org>
 <305d9907-9668-d362-1ff2-49a5e9f90e42@intel.com>
 <20230927113510-mutt-send-email-mst@kernel.org>
 <558fe3d6-0b81-4def-7256-52ac3cbffa8f@intel.com>
 <20231011061508-mutt-send-email-mst@kernel.org>
 <373821b2-1a1e-3bf3-51dc-8af54db85d00@intel.com>
 <PH0PR12MB5481D2B24BB499D18914351ADCCCA@PH0PR12MB5481.namprd12.prod.outlook.com>
 <cf9ab678-e894-1825-5728-0c212d76c737@intel.com>
MIME-Version: 1.0
In-Reply-To: <cf9ab678-e894-1825-5728-0c212d76c737@intel.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Subject: [virtio-dev] Re: [virtio-comment] Re: [virtio-dev] Re: [PATCH 0/5] virtio:
 introduce SUSPEND bit and vq state

On Thu, Oct 12, 2023 at 06:57:35PM +0800, Zhu, Lingshan wrote:
> 
> 
> On 10/11/2023 7:52 PM, Parav Pandit wrote:
> > > From: Zhu, Lingshan <lingshan.zhu@intel.com>
> > > Sent: Wednesday, October 11, 2023 4:09 PM
> > > I am sure I have not ignored any questions.
> > What about below one?
> > 
> > https://lore.kernel.org/virtio-dev/20230921011221-mutt-send-email-mst@kernel.org/
> This is to discuss a attacking model, I have given the answer in another
> thread,
> I have even provide an example of how malicious SW can dump guest security
> through admin vq

No one cares, without encryption hypervisor is in control anyway.


---------------------------------------------------------------------
To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org

