Return-Path: <virtio-dev-return-12013-virtio-dev=archiver.kernel.org@lists.oasis-open.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from ws5-mx01.kavi.com (ws5-mx01.kavi.com [34.193.7.191])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3018FC76188
	for <virtio-dev@archiver.kernel.org>; Wed,  5 Apr 2023 10:06:14 +0000 (UTC)
Received: from lists.oasis-open.org (oasis.ws5.connectedcommunity.org [10.110.1.242])
	by ws5-mx01.kavi.com (Postfix) with ESMTP id 8CE5B2B065
	for <virtio-dev@archiver.kernel.org>; Wed,  5 Apr 2023 10:06:13 +0000 (UTC)
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id 67DA39865B3
	for <virtio-dev@archiver.kernel.org>; Wed,  5 Apr 2023 10:06:13 +0000 (UTC)
Received: from host09.ws5.connectedcommunity.org (host09.ws5.connectedcommunity.org [10.110.1.97])
	by lists.oasis-open.org (Postfix) with QMQP
	id 52B0D983DE1; Wed,  5 Apr 2023 10:06:13 +0000 (UTC)
Mailing-List: contact virtio-dev-help@lists.oasis-open.org; run by ezmlm
List-ID: <virtio-dev.lists.oasis-open.org>
Sender: <virtio-dev@lists.oasis-open.org>
Precedence: bulk
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id 427869865A7
	for <virtio-dev@lists.oasis-open.org>; Wed,  5 Apr 2023 10:06:13 +0000 (UTC)
X-Virus-Scanned: amavisd-new at kavi.com
X-MC-Unique: cney8dddMqiqM7va885qoQ-1
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680689168;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=K7tqdHp0z7SrsceuGaqk3f4Dn2eBRCUCgxJHv4nhpXM=;
        b=tMSYgdPpCbYwG0o5D+O/Hjc4J2hu0CS0Hsr/nxu7rwGn2OwujK+/2bDGCpvGLq8ckb
         hpM262yL0qLAzeb7IR/0kUmmc0mCY96Y1M498lfdFTkajwJpss0Pto19HEYwjB5NgkcN
         U03NraZa6z8qh9dNRackSu+Juce3L/HCln2lIGIAKaXZYPSAO3H9mIaRgJ6fqxoq88h+
         kd53T6WwPPckuI8WXpWSLNJLiMocfQDWwSRPeWD46GBe2Qd4EI5IU7P/UPe915aaSvxB
         D8vkLUekEt5cukEVPGoeYIw0p4WNf81AAdK0H6IBCc22U2/g6m8RvY42hLg6jBNMTQMd
         ecJA==
X-Gm-Message-State: AAQBX9d//iQQ7HXeNcoi6JMG9e+mAtEoBaPz8VjJXUnNC/AHujLu43/i
	VVOcSBrDvjo7yxtXAjkVsnT2AEMMzDnwH5otrQxxcpA/P9yiO8h8PqdZwXb9mRFTPq5mWFp1QfP
	DxBXxonNE7PNWe/uDsYvzeEI+bish
X-Received: by 2002:a17:906:a254:b0:933:37f4:2fe0 with SMTP id bi20-20020a170906a25400b0093337f42fe0mr2333567ejb.46.1680689168547;
        Wed, 05 Apr 2023 03:06:08 -0700 (PDT)
X-Google-Smtp-Source: AKy350Yf1A5XZK4oo80SHWAZ2GiHPkSEf5Qh7hmicDEC8A80aMGY6813loQHdU4+ZIZl0KypQH0u+A==
X-Received: by 2002:a17:906:a254:b0:933:37f4:2fe0 with SMTP id bi20-20020a170906a25400b0093337f42fe0mr2333546ejb.46.1680689168281;
        Wed, 05 Apr 2023 03:06:08 -0700 (PDT)
Date: Wed, 5 Apr 2023 06:06:03 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Alex =?iso-8859-1?Q?Benn=E9e?= <alex.bennee@linaro.org>
Cc: Viresh Kumar <viresh.kumar@linaro.org>, qemu-devel@nongnu.org,
	virtio-dev@lists.oasis-open.org,
	Stefan Hajnoczi <stefanha@redhat.com>,
	Vincent Guittot <vincent.guittot@linaro.org>,
	stratos-dev@op-lists.linaro.org,
	Oleksandr Tyshchenko <olekstysh@gmail.com>, xen-devel@lists.xen.org,
	Andrew Cooper <andrew.cooper3@citrix.com>,
	Juergen Gross <jgross@suse.com>,
	Sebastien Boeuf <sebastien.boeuf@intel.com>,
	Liu Jiang <gerry@linux.alibaba.com>,
	Mathieu Poirier <mathieu.poirier@linaro.org>
Message-ID: <20230405060340-mutt-send-email-mst@kernel.org>
References: <cover.1678351495.git.viresh.kumar@linaro.org>
 <20230405080512.nvxiw4lv7hyuzqej@vireshk-i7>
 <87h6tulkae.fsf@linaro.org>
MIME-Version: 1.0
In-Reply-To: <87h6tulkae.fsf@linaro.org>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
Subject: [virtio-dev] Re: [PATCH V3 0/2] qemu: vhost-user: Support Xen memory mapping
 quirks

On Wed, Apr 05, 2023 at 11:00:34AM +0100, Alex Bennée wrote:
> 
> Viresh Kumar <viresh.kumar@linaro.org> writes:
> 
> > On 09-03-23, 14:20, Viresh Kumar wrote:
> >> Hello,
> >> 
> >> This patchset tries to update the vhost-user protocol to make it support special
> >> memory mapping required in case of Xen hypervisor.
> >> 
> >> The first patch is mostly cleanup and second one introduces a new xen specific
> >> feature.
> >
> > Can we apply this now ? I have developed code for rust-vmm crates
> > based on this and we need to get this merged/finalized first before
> > merging those changes.
> 
> 
> I've queued into my virtio/vhost-user-device series so I'll get merged
> with that series unless mst wants to take it now.

Well the patches are tagged and I was going to take these after the release.
Probably easier not to work on this in two trees.
Still if there's something in your tree being blocked
by these patches then
Acked-by: Michael S. Tsirkin <mst@redhat.com>
Let me know.


> >
> > Thanks.
> 
> 
> -- 
> Alex Bennée
> Virtualisation Tech Lead @ Linaro


---------------------------------------------------------------------
To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org

