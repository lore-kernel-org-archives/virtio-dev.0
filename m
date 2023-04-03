Return-Path: <virtio-dev-return-11921-virtio-dev=archiver.kernel.org@lists.oasis-open.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from ws5-mx01.kavi.com (ws5-mx01.kavi.com [34.193.7.191])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D6CB0C76196
	for <virtio-dev@archiver.kernel.org>; Mon,  3 Apr 2023 17:36:09 +0000 (UTC)
Received: from lists.oasis-open.org (oasis.ws5.connectedcommunity.org [10.110.1.242])
	by ws5-mx01.kavi.com (Postfix) with ESMTP id 4EE1F3710C
	for <virtio-dev@archiver.kernel.org>; Mon,  3 Apr 2023 17:36:09 +0000 (UTC)
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id 3E7029863FA
	for <virtio-dev@archiver.kernel.org>; Mon,  3 Apr 2023 17:36:09 +0000 (UTC)
Received: from host09.ws5.connectedcommunity.org (host09.ws5.connectedcommunity.org [10.110.1.97])
	by lists.oasis-open.org (Postfix) with QMQP
	id 33E9F9863DE; Mon,  3 Apr 2023 17:36:09 +0000 (UTC)
Mailing-List: contact virtio-dev-help@lists.oasis-open.org; run by ezmlm
List-ID: <virtio-dev.lists.oasis-open.org>
Sender: <virtio-dev@lists.oasis-open.org>
Precedence: bulk
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id 24BE99863DF
	for <virtio-dev@lists.oasis-open.org>; Mon,  3 Apr 2023 17:36:09 +0000 (UTC)
X-Virus-Scanned: amavisd-new at kavi.com
X-MC-Unique: BFqc8p1VPpyxr1to64GlDA-1
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680543366;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=kRxa0YKbguBcG37lL5IXPmAB9UHNR9qC66djwGg5+XY=;
        b=scu5DU7D0v+kyVTFuXGGK10VwOyTRb5HFHtb4ct+0l0f4PQ7sZZiQJFBspScpJmT7c
         442HHA1xthuJxZO3Ync0MV7UFxLdn89EACjlHSsuohG+kESeaHS2H3mgU6PPB7ns1pIf
         /e45/IPgDRwqGIPe5W0Y5jHoW50LioXWSc6UtUBPnNOWrBNwhYVFbpFHGA+trnmTl7OA
         dEjKvbuEkOa0tddaWj5D9ATNZ89w5sHz8sxEU5Y3L1BhUDCRcomhGdYXk8N4JqUirWnO
         c0dm8dCkz3GWYhMKZE/mIWGq8Jr23/Ac5WBIOalBOfy2svRabcdecdnkKdVRhmfhfxEa
         Pcsg==
X-Gm-Message-State: AAQBX9fk6e3Tj6m0ajsl4PKpz+Y7HhFk+fbWiXz54fy/IUhn7NjCBL8+
	1gvpl6885euSoVnBPRqIQbxF8pDtQsCmzI5da/8bFMFqIwFuC6hEg58kjdUQccNGEqVvKdsa+TG
	NdOcy7cUmiTmHbLHa0OCr4+SF+B5K
X-Received: by 2002:a05:6402:68a:b0:500:47ed:9784 with SMTP id f10-20020a056402068a00b0050047ed9784mr18115781edy.14.1680543366041;
        Mon, 03 Apr 2023 10:36:06 -0700 (PDT)
X-Google-Smtp-Source: AKy350ZeBwpH/XQY7l9EvuJLwM3aTGzHzseeXKXbq/GXuvWXoXuy0gvDUtkeWJVcJ9D9wmn4rGwqSA==
X-Received: by 2002:a05:6402:68a:b0:500:47ed:9784 with SMTP id f10-20020a056402068a00b0050047ed9784mr18115771edy.14.1680543365798;
        Mon, 03 Apr 2023 10:36:05 -0700 (PDT)
Date: Mon, 3 Apr 2023 13:35:59 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Christoph Hellwig <hch@infradead.org>
Cc: Dmitry Fomichev <dmitry.fomichev@wdc.com>, Jens Axboe <axboe@kernel.dk>,
	virtio-dev@lists.oasis-open.org,
	Damien Le Moal <damien.lemoal@opensource.wdc.com>,
	Sam Li <faithilikerun@gmail.com>,
	virtualization@lists.linux-foundation.org,
	linux-block@vger.kernel.org
Message-ID: <20230403133334-mutt-send-email-mst@kernel.org>
References: <20230330214953.1088216-1-dmitry.fomichev@wdc.com>
 <20230330214953.1088216-2-dmitry.fomichev@wdc.com>
 <ZCrtjrYQHnppV8gN@infradead.org>
MIME-Version: 1.0
In-Reply-To: <ZCrtjrYQHnppV8gN@infradead.org>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Subject: [virtio-dev] Re: [PATCH v2 1/2] virtio-blk: migrate to the latest patchset version

On Mon, Apr 03, 2023 at 08:15:26AM -0700, Christoph Hellwig wrote:
> What is "migrate to the latest patchset version" even supposed to mean?
> 
> I don't think that belongs into a kernel commit description.

I think this should be something like "update to latest interface version".

-- 
MST


---------------------------------------------------------------------
To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org

