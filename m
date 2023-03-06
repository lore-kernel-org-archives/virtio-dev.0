Return-Path: <virtio-dev-return-11461-virtio-dev=archiver.kernel.org@lists.oasis-open.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from ws5-mx01.kavi.com (ws5-mx01.kavi.com [34.193.7.191])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 376E3C61DA4
	for <virtio-dev@archiver.kernel.org>; Mon,  6 Mar 2023 22:50:30 +0000 (UTC)
Received: from lists.oasis-open.org (oasis.ws5.connectedcommunity.org [10.110.1.242])
	by ws5-mx01.kavi.com (Postfix) with ESMTP id 3AEE4157F0D
	for <virtio-dev@archiver.kernel.org>; Mon,  6 Mar 2023 22:50:29 +0000 (UTC)
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id EC8429866C5
	for <virtio-dev@archiver.kernel.org>; Mon,  6 Mar 2023 22:50:28 +0000 (UTC)
Received: from host09.ws5.connectedcommunity.org (host09.ws5.connectedcommunity.org [10.110.1.97])
	by lists.oasis-open.org (Postfix) with QMQP
	id 7B63E9866C2; Mon,  6 Mar 2023 22:50:28 +0000 (UTC)
Mailing-List: contact virtio-dev-help@lists.oasis-open.org; run by ezmlm
List-ID: <virtio-dev.lists.oasis-open.org>
Sender: <virtio-dev@lists.oasis-open.org>
Precedence: bulk
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id 907C99866BF
	for <virtio-dev@lists.oasis-open.org>; Mon,  6 Mar 2023 22:50:01 +0000 (UTC)
X-Virus-Scanned: amavisd-new at kavi.com
X-MC-Unique: IeEru_VwPASzUPZNQbVPZw-1
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678142996;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=1klO/5jbx7TMiurPDQx9cnjYZl+9qNLvm7Kx1TkEzVw=;
        b=zPiiTUj0XflQDnFyHjp1mpgB0547K/T7z5d7yk498FORJgLsSiRVCX5PUsiF4zsK3K
         DKTjw+Ffgvn64drbjeVjd/hKVcBmEJJkmE7/I8po1rrKHA2RiRKgAu1KIuOV6aHD1sMO
         BVgVYmtT6A1eqjm2a4s1Yy/lEx/eOSCck4lEByO3vxFqroZskMVItDBPKDUJbx3MA0bT
         ZhE54LMlWGol8W0akpSWvQdS46fy17eRCfinm5tDVV39e+BeteZ8Oun/0QTdjsPJgzlt
         NBCJnAGKMNPl6OyeIetHhSjSicIZdoN4GFhkin19PuxgEMi0wRV3oXM0QzdJhk9kAF8o
         Gutw==
X-Gm-Message-State: AO0yUKXDfAAUDPp7coEtSS1Gy2TDiIvqUp1hXI63d95oXRpi6+SXxCCJ
	VgmiZ8p5fUtMLbYeRzXF+083ncgx/XEYqUijM90h2IRPAADcmJu8nPlTlcfwZpT7lXXrcpnR4/j
	7GqeaKeB0O9uW3YtQjY7SXoWPyL+c
X-Received: by 2002:a05:600c:4509:b0:3eb:32ff:da8 with SMTP id t9-20020a05600c450900b003eb32ff0da8mr11589174wmo.16.1678142996310;
        Mon, 06 Mar 2023 14:49:56 -0800 (PST)
X-Google-Smtp-Source: AK7set/oeZjvI5ZlOo3mj9Umltf20LkhnX3OIDnPNUrdviNyt4GO1kNDJPWFw/B4qf4raNHcoPFP+A==
X-Received: by 2002:a05:600c:4509:b0:3eb:32ff:da8 with SMTP id t9-20020a05600c450900b003eb32ff0da8mr11589149wmo.16.1678142995965;
        Mon, 06 Mar 2023 14:49:55 -0800 (PST)
Date: Mon, 6 Mar 2023 17:49:51 -0500
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Max Gurtovoy <mgurtovoy@nvidia.com>
Cc: Stefan Hajnoczi <stefanha@redhat.com>,
	virtio-comment@lists.oasis-open.org,
	virtio-dev@lists.oasis-open.org, jasowang@redhat.com,
	cohuck@redhat.com, sgarzare@redhat.com, nrupal.jani@intel.com,
	Piotr.Uminski@intel.com, hang.yuan@intel.com,
	virtio@lists.oasis-open.org, Zhu Lingshan <lingshan.zhu@intel.com>,
	pasic@linux.ibm.com, Shahaf Shuler <shahafs@nvidia.com>,
	Parav Pandit <parav@nvidia.com>
Message-ID: <20230306174850-mutt-send-email-mst@kernel.org>
References: <cover.1677761896.git.mst@redhat.com>
 <20c81b66f0b21b5bd646c24840ac3f8462c86acf.1677761896.git.mst@redhat.com>
 <20230302204007.GD2554028@fedora>
 <20230302190230-mutt-send-email-mst@kernel.org>
 <027fff1b-8ed7-abc0-2331-b188b8822bf4@nvidia.com>
MIME-Version: 1.0
In-Reply-To: <027fff1b-8ed7-abc0-2331-b188b8822bf4@nvidia.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Subject: [virtio-dev] Re: [virtio-comment] Re: [PATCH v10 04/10] admin: introduce virtio
 admin virtqueues

On Mon, Mar 06, 2023 at 05:14:09PM +0200, Max Gurtovoy wrote:
> > > This would allow pipelining
> > > dependent commands but prevent long-running commands because the
> > > virtqueue is blocked while executing a command.
> > 
> > we have multiple vqs for that.
> 
> why do we need multiple admin vqs ?

You are literally replying to a discussion with a use-case.

-- 
MST


---------------------------------------------------------------------
To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org

