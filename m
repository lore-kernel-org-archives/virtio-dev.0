Return-Path: <virtio-dev-return-13425-virtio-dev=archiver.kernel.org@lists.oasis-open.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from ws5-mx01.kavi.com (ws5-mx01.kavi.com [34.193.7.191])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 27BC1C001DC
	for <virtio-dev@archiver.kernel.org>; Mon, 31 Jul 2023 09:12:09 +0000 (UTC)
Received: from lists.oasis-open.org (oasis.ws5.connectedcommunity.org [10.110.1.242])
	by ws5-mx01.kavi.com (Postfix) with ESMTP id 6FBE62CAD4
	for <virtio-dev@archiver.kernel.org>; Mon, 31 Jul 2023 09:12:08 +0000 (UTC)
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id 4C976986410
	for <virtio-dev@archiver.kernel.org>; Mon, 31 Jul 2023 09:12:08 +0000 (UTC)
Received: from host09.ws5.connectedcommunity.org (host09.ws5.connectedcommunity.org [10.110.1.97])
	by lists.oasis-open.org (Postfix) with QMQP
	id 2F79D98636F; Mon, 31 Jul 2023 09:12:08 +0000 (UTC)
Mailing-List: contact virtio-dev-help@lists.oasis-open.org; run by ezmlm
List-ID: <virtio-dev.lists.oasis-open.org>
Sender: <virtio-dev@lists.oasis-open.org>
Precedence: bulk
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id 1A02398637C
	for <virtio-dev@lists.oasis-open.org>; Mon, 31 Jul 2023 09:12:08 +0000 (UTC)
X-Virus-Scanned: amavisd-new at kavi.com
X-MC-Unique: 07a3unDjOp-TJ-zQP_JGww-1
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690794724; x=1691399524;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=qJhT3l2NEk9PpQ+1C7KEyFzzGT4ynYOP91mgc17w0bI=;
        b=PO7zysufDxXJG5e/C+6F8ysfwTVwzhlVIe1anfu4X4mOa2i7KgAcjQv2ntX8UDOqE5
         t+VgYY0wfLQE377m7h8waYRahgVfRUFIM78HS3g38yCSS3XDO2vOKMVydkaZO15mWiQV
         2TQx/0QkvN0eI1TrX7oTiQsdYq5U43KxLUqn+FJGy8eQBt+GWwlXomZbzpVn2HGFznhW
         SvlIIMnSACmqRwJxIfyd34VUMTq+IbTWUi4DNX/dDU4+6i8GYH/BFDQ37fkaAZJ9WPKp
         pFpqhqP4gClGVhArZKnSE/2AxHvaYuSBZF7kuLWokB/DG/G/y40u/Muiwr8fwc/7MTsE
         Qnww==
X-Gm-Message-State: ABy/qLaYH7ZNojTBSCOQjqPrlZEIyafcYgC4gIzM4o23gmEJUdcsF+A3
	m+KRbOr0u/quRR3S56zIbgTIrzko1pmcsq3Vf0beg+XpXeEXhRBrKKJ689UxY/J0EHrHWqiD3UU
	y4S2YXy3ypnEuUTg+hpJpto2kDr/4
X-Received: by 2002:a17:907:7709:b0:98d:5ae2:f1c with SMTP id kw9-20020a170907770900b0098d5ae20f1cmr6484487ejc.34.1690794723951;
        Mon, 31 Jul 2023 02:12:03 -0700 (PDT)
X-Google-Smtp-Source: APBJJlGezhlW5DnP2jd+oOtGQvHQV2Hd/k+/RN6X/HFJ8LBbk+rnprAswGkr5SwNzM+VaEuOs+D+CQ==
X-Received: by 2002:a17:907:7709:b0:98d:5ae2:f1c with SMTP id kw9-20020a170907770900b0098d5ae20f1cmr6484476ejc.34.1690794723615;
        Mon, 31 Jul 2023 02:12:03 -0700 (PDT)
Date: Mon, 31 Jul 2023 05:12:00 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Parav Pandit <parav@nvidia.com>
Cc: Xuan Zhuo <xuanzhuo@linux.alibaba.com>,
	"virtio-dev@lists.oasis-open.org" <virtio-dev@lists.oasis-open.org>,
	"jasowang@redhat.com" <jasowang@redhat.com>,
	"virtio-comment@lists.oasis-open.org" <virtio-comment@lists.oasis-open.org>
Message-ID: <20230731050908-mutt-send-email-mst@kernel.org>
References: <20230726081229.55947-1-xuanzhuo@linux.alibaba.com>
 <20230726070801-mutt-send-email-mst@kernel.org>
 <1690422490.8491526-1-xuanzhuo@linux.alibaba.com>
 <PH0PR12MB548149ED4C687913EDA3EED9DC05A@PH0PR12MB5481.namprd12.prod.outlook.com>
MIME-Version: 1.0
In-Reply-To: <PH0PR12MB548149ED4C687913EDA3EED9DC05A@PH0PR12MB5481.namprd12.prod.outlook.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Subject: [virtio-dev] Re: [PATCH v13] virtio-net: support device stats

On Mon, Jul 31, 2023 at 04:32:22AM +0000, Parav Pandit wrote:
> I have two proposals to for the dma interface and we should discuss that in separate thread to not mix the cvq parts of the stats.
> I will start the thread shortly and put pointer to this requirement of counters + many others that we are discussing including ntuple.

Great! I agree it is best to discuss infrastructure work like this
now while we are in freeze. Merge this early on 1.4 branch so
everything else can depend on it.

-- 
MST


---------------------------------------------------------------------
To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org

