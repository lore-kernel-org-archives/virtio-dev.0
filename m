Return-Path: <virtio-dev-return-12015-virtio-dev=archiver.kernel.org@lists.oasis-open.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from ws5-mx01.kavi.com (ws5-mx01.kavi.com [34.193.7.191])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4781CC76188
	for <virtio-dev@archiver.kernel.org>; Wed,  5 Apr 2023 10:44:54 +0000 (UTC)
Received: from lists.oasis-open.org (oasis.ws5.connectedcommunity.org [10.110.1.242])
	by ws5-mx01.kavi.com (Postfix) with ESMTP id 89CCA2B055
	for <virtio-dev@archiver.kernel.org>; Wed,  5 Apr 2023 10:44:53 +0000 (UTC)
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id 699AF9865B7
	for <virtio-dev@archiver.kernel.org>; Wed,  5 Apr 2023 10:44:53 +0000 (UTC)
Received: from host09.ws5.connectedcommunity.org (host09.ws5.connectedcommunity.org [10.110.1.97])
	by lists.oasis-open.org (Postfix) with QMQP
	id 532D2983DE1; Wed,  5 Apr 2023 10:44:53 +0000 (UTC)
Mailing-List: contact virtio-dev-help@lists.oasis-open.org; run by ezmlm
List-ID: <virtio-dev.lists.oasis-open.org>
Sender: <virtio-dev@lists.oasis-open.org>
Precedence: bulk
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id 3E5E99865A7
	for <virtio-dev@lists.oasis-open.org>; Wed,  5 Apr 2023 10:44:53 +0000 (UTC)
X-Virus-Scanned: amavisd-new at kavi.com
X-MC-Unique: P_vn9T7nM9i4E5QxokdIwg-1
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680691488;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=kq6oZ7N2bYTf0eEXEKbV1aFmSrlbXHt85D5v+zP8YuE=;
        b=os4Ew7Ka5G8qlnRWTXwdhX1JTfWonB2CdQzde4M75YsDOSuXqbvYyjAXmz3wiCBCYJ
         t45R3fJk3gjddccHp+Hw03CzNyF6FCqcq9ydlGBrDTrJx5r0njIk9tyFafZ8lRXArZIw
         1nuKNWzD758/ykUVDymZN2vnd3HIuG4bdxkNcQwAEftyocpywjIjTkeiuOkpyysyU//3
         SkTslHISr/K7kaD701OzLVwYlDl07GfBOkOQ9AyNbW78KCcfFFWhEz0Sy0TzKcJd1KK3
         zlbQNbej80MgkJ2fVpzEDhw6yd9jpYZbvgh9Bp41mV+MLupsRR5CGoma4Z2zHNmBbs0i
         O06A==
X-Gm-Message-State: AAQBX9d9caOH7zOdPYr6g06rxpix1x/eBLZTF8BXwgij7Mt1Fg455f6U
	xav9eWTeyqjcsorlqsK3h+ojE96UNrWG/o1FfOJHLUYSfNgVFXUPyEvLG6TOsvmCorkf2xV9IpA
	KyjyhbOtJsliHugcOKV6IJ1EwlueQ
X-Received: by 2002:a17:906:d045:b0:931:624b:6804 with SMTP id bo5-20020a170906d04500b00931624b6804mr2345365ejb.33.1680691487917;
        Wed, 05 Apr 2023 03:44:47 -0700 (PDT)
X-Google-Smtp-Source: AKy350b5k+F7FQS0kEh/ahvkTDuRpd40DUgmdol+8mUYtq06ub6whVh6ZTdy0b/m/9U1TYG1Nw5Bew==
X-Received: by 2002:a17:906:d045:b0:931:624b:6804 with SMTP id bo5-20020a170906d04500b00931624b6804mr2345345ejb.33.1680691487657;
        Wed, 05 Apr 2023 03:44:47 -0700 (PDT)
Date: Wed, 5 Apr 2023 06:44:42 -0400
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
Message-ID: <20230405064417-mutt-send-email-mst@kernel.org>
References: <cover.1678351495.git.viresh.kumar@linaro.org>
 <20230405080512.nvxiw4lv7hyuzqej@vireshk-i7>
 <87h6tulkae.fsf@linaro.org>
 <20230405060340-mutt-send-email-mst@kernel.org>
 <87cz4ilj4j.fsf@linaro.org>
MIME-Version: 1.0
In-Reply-To: <87cz4ilj4j.fsf@linaro.org>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
Subject: [virtio-dev] Re: [PATCH V3 0/2] qemu: vhost-user: Support Xen memory mapping
 quirks

On Wed, Apr 05, 2023 at 11:24:43AM +0100, Alex Bennée wrote:
> 
> "Michael S. Tsirkin" <mst@redhat.com> writes:
> 
> > On Wed, Apr 05, 2023 at 11:00:34AM +0100, Alex Bennée wrote:
> >> 
> >> Viresh Kumar <viresh.kumar@linaro.org> writes:
> >> 
> >> > On 09-03-23, 14:20, Viresh Kumar wrote:
> >> >> Hello,
> >> >> 
> >> >> This patchset tries to update the vhost-user protocol to make it support special
> >> >> memory mapping required in case of Xen hypervisor.
> >> >> 
> >> >> The first patch is mostly cleanup and second one introduces a new xen specific
> >> >> feature.
> >> >
> >> > Can we apply this now ? I have developed code for rust-vmm crates
> >> > based on this and we need to get this merged/finalized first before
> >> > merging those changes.
> >> 
> >> 
> >> I've queued into my virtio/vhost-user-device series so I'll get merged
> >> with that series unless mst wants to take it now.
> >
> > Well the patches are tagged and I was going to take these after the release.
> > Probably easier not to work on this in two trees.
> > Still if there's something in your tree being blocked
> > by these patches then
> > Acked-by: Michael S. Tsirkin <mst@redhat.com>
> > Let me know.
> 
> The virtio/vhost-user-device tree work is orthogonal to this vhost-user
> enhancement although all the work is related to our latest VirtIO
> project inside Linaro, Orko:
> https://linaro.atlassian.net/wiki/spaces/ORKO/overview
> 
> So if you are happy please take these patches now for when the tree
> re-opens.

Yes, I tagged them for when the tree reopens.

> >
> >
> >> >
> >> > Thanks.
> >> 
> >> 
> >> -- 
> >> Alex Bennée
> >> Virtualisation Tech Lead @ Linaro
> 
> 
> -- 
> Alex Bennée
> Virtualisation Tech Lead @ Linaro


---------------------------------------------------------------------
To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org

