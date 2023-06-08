Return-Path: <virtio-dev-return-12890-virtio-dev=archiver.kernel.org@lists.oasis-open.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from ws5-mx01.kavi.com (ws5-mx01.kavi.com [34.193.7.191])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 30A86C7EE23
	for <virtio-dev@archiver.kernel.org>; Thu,  8 Jun 2023 14:47:42 +0000 (UTC)
Received: from lists.oasis-open.org (oasis.ws5.connectedcommunity.org [10.110.1.242])
	by ws5-mx01.kavi.com (Postfix) with ESMTP id 7CE824290A
	for <virtio-dev@archiver.kernel.org>; Thu,  8 Jun 2023 14:47:41 +0000 (UTC)
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id 65AE898666F
	for <virtio-dev@archiver.kernel.org>; Thu,  8 Jun 2023 14:47:41 +0000 (UTC)
Received: from host09.ws5.connectedcommunity.org (host09.ws5.connectedcommunity.org [10.110.1.97])
	by lists.oasis-open.org (Postfix) with QMQP
	id 4F336986655; Thu,  8 Jun 2023 14:47:41 +0000 (UTC)
Mailing-List: contact virtio-dev-help@lists.oasis-open.org; run by ezmlm
List-ID: <virtio-dev.lists.oasis-open.org>
Sender: <virtio-dev@lists.oasis-open.org>
Precedence: bulk
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id 3CFE798666B
	for <virtio-dev@lists.oasis-open.org>; Thu,  8 Jun 2023 14:47:41 +0000 (UTC)
X-Virus-Scanned: amavisd-new at kavi.com
X-MC-Unique: nn_KbJu5Oi6dUBwfQWVHlQ-1
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686235656; x=1688827656;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=nHUeF7Fdpa3urawPs+M58Re+lIvHK7cB6oH5IvV4gqM=;
        b=KNxayHUfrliOoNO5cGdIaH2XNlU1l7QW8f2LnASY0iRy7H6KR9fFCHMfBJNf/1qjxQ
         IDPYpGMicwfADEWrZCqA+YRCxwZkEtqpheQCC2v1O8fcxoUti7ugJldrQweSbKKPT/wi
         yVccwcDDpj7aaubup7fJSCghxQiQP4385d2ip99YRLYO3o5oNTNW3GL82PFm7TYwtRLb
         hACYArXIYUI2fiIJBT1+auR3heFm8UpHMg7Dh1l7muQbNu5PuoDIe+f1TuyVGZcLuHlb
         erxin9FnHXaU1MZ/gr2I8x5JYBQdtZ8/INP7T8gvyUdHgrd9yiZiSop/aBVKnWn//VLx
         a+bg==
X-Gm-Message-State: AC+VfDw7OIE2ndDZrGONzSeo+Kx4sB+cF6eWLKbg74KaC14Fhzai+zWQ
	dRX6TI5Ym/hOJR5BUKUP27ptPf/MuHt0EOvu2fv++oFQdfcLhrZyu/3Y/zeFpp4rfoHNKRqtM7w
	AsNmdtHATW/cVrsXvGazcbV7pshcE
X-Received: by 2002:a5d:5642:0:b0:307:bd64:f5a4 with SMTP id j2-20020a5d5642000000b00307bd64f5a4mr7567661wrw.52.1686235656583;
        Thu, 08 Jun 2023 07:47:36 -0700 (PDT)
X-Google-Smtp-Source: ACHHUZ4NNKCGh90aTdRD4yroRreP7meD2t+1dCKmEukVMchsJmvoqhxK6iYtDzAJ09wLbXlai17pRw==
X-Received: by 2002:a5d:5642:0:b0:307:bd64:f5a4 with SMTP id j2-20020a5d5642000000b00307bd64f5a4mr7567646wrw.52.1686235656350;
        Thu, 08 Jun 2023 07:47:36 -0700 (PDT)
Date: Thu, 8 Jun 2023 10:47:32 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Parav Pandit <parav@nvidia.com>
Cc: Heng Qi <hengqi@linux.alibaba.com>, Jason Wang <jasowang@redhat.com>,
	Yuri Benditovich <yuri.benditovich@daynix.com>,
	Xuan Zhuo <xuanzhuo@linux.alibaba.com>,
	"virtio-comment@lists.oasis-open.org" <virtio-comment@lists.oasis-open.org>,
	"virtio-dev@lists.oasis-open.org" <virtio-dev@lists.oasis-open.org>
Message-ID: <20230608104710-mutt-send-email-mst@kernel.org>
References: <20230605071608.73016-1-hengqi@linux.alibaba.com>
 <DM8PR12MB54805C0A8E0E617EE2149851DC53A@DM8PR12MB5480.namprd12.prod.outlook.com>
 <20230608064042.GC28580@h68b04307.sqa.eu95>
 <PH0PR12MB548119AC6E8CF4A5EBCBA4D3DC50A@PH0PR12MB5481.namprd12.prod.outlook.com>
 <20230608104119-mutt-send-email-mst@kernel.org>
 <PH0PR12MB54819986416B73C860DF7A76DC50A@PH0PR12MB5481.namprd12.prod.outlook.com>
MIME-Version: 1.0
In-Reply-To: <PH0PR12MB54819986416B73C860DF7A76DC50A@PH0PR12MB5481.namprd12.prod.outlook.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Subject: Re: [virtio-dev] RE: [PATCH v15] virtio-net: support inner header
 hash

On Thu, Jun 08, 2023 at 02:45:15PM +0000, Parav Pandit wrote:
> 
> > From: Michael S. Tsirkin <mst@redhat.com>
> > Sent: Thursday, June 8, 2023 10:42 AM
> 
> > > > 2. hand over to RSS the ability to specify a hash based on the outer source
> > port.
> > > > That is, we can add VIRTIO_NET_RSS_HASH_TUNNEL_SRC_PORT_UDP_{v4,
> > v6,
> > > > EX} in \field{supported_hash_types} to indicate that the hash should
> > > > be calculated using the outer source port for all UDP tunneling protocols.
> > > > This approach removes the need for \field{hash_option} and makes the
> > > > line between VIRTIO_NET_F_HASH_TUNNEL and VIRTIO_NET_F_RSS clearer.
> > > >
> > > #2 is preferred.
> > >
> > > But I must be missing something.
> > > Without VIRTIO_NET_RSS_HASH_TUNNEL_SRC_PORT_UDP_X, today if one
> > wants
> > > to do RSS based on the outer UDP ports, It is already supported by the RSS
> > (even in presence of the inner header).
> > >
> > > So why do have to introduce
> > VIRTIO_NET_RSS_HASH_TUNNEL_SRC_PORT_UDP_X?
> > 
> > they want an option to ignore all other header fields.
> 
> Than that looks like rss config extension on which fields of the packet to use for RSS.

yes, but also, only for specific packet type and dest port #s.


-- 
MST


---------------------------------------------------------------------
To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org

