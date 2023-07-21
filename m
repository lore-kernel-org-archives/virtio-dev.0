Return-Path: <virtio-dev-return-13399-virtio-dev=archiver.kernel.org@lists.oasis-open.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from ws5-mx01.kavi.com (ws5-mx01.kavi.com [34.193.7.191])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 49377EB64DD
	for <virtio-dev@archiver.kernel.org>; Fri, 21 Jul 2023 12:41:56 +0000 (UTC)
Received: from lists.oasis-open.org (oasis.ws5.connectedcommunity.org [10.110.1.242])
	by ws5-mx01.kavi.com (Postfix) with ESMTP id A064E120D4F
	for <virtio-dev@archiver.kernel.org>; Fri, 21 Jul 2023 12:41:55 +0000 (UTC)
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id 7C87A986849
	for <virtio-dev@archiver.kernel.org>; Fri, 21 Jul 2023 12:41:55 +0000 (UTC)
Received: from host09.ws5.connectedcommunity.org (host09.ws5.connectedcommunity.org [10.110.1.97])
	by lists.oasis-open.org (Postfix) with QMQP
	id 660FA98683F; Fri, 21 Jul 2023 12:41:55 +0000 (UTC)
Mailing-List: contact virtio-dev-help@lists.oasis-open.org; run by ezmlm
List-ID: <virtio-dev.lists.oasis-open.org>
Sender: <virtio-dev@lists.oasis-open.org>
Precedence: bulk
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id 5241F986840
	for <virtio-dev@lists.oasis-open.org>; Fri, 21 Jul 2023 12:41:55 +0000 (UTC)
X-Virus-Scanned: amavisd-new at kavi.com
X-MC-Unique: foVhXS_yNMqvYjflfueiWg-1
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689943312; x=1690548112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=EjS2GpoRJ9dp3WX/fxGhZk30ZGM6meBTBw3QhEJSwXk=;
        b=KYpuYk7aV9VgPUUECMn7wAdMOTpFBF4NkkpNzEs9r8ivYtXl6U15uRZXfra75z4Maa
         r/a4mtnApR6h5I6nLBkABqePm6WprS525B57+p4msJI0aOA3J/fts8EGzFtx0DtZMWze
         vHAsJLllwvb0M5X53a+zbAutGn+NBKFfJyyrPKofPkqrknbJJas3uOaPilIzfuBVx/hs
         ywMj/cMB0AndJz1XeSyrF/4sSrmSu3KbHMq0eRvw5UQHWn5TdSmPmHQ3pv5bCeTtu0PE
         aWywHxhyt71fB+swfPKRj5Xcqfm68h3gTus05I2nz0c1tp36yYprHg6IhpfsHDWQxvtv
         APDg==
X-Gm-Message-State: ABy/qLaWo1IDdV9BA01e0+1+KtLQnTu5qmpRCvnyMWr8WRxlqwSe2cSJ
	GM/rQ21ctPLHlsg6YI+RO4Uq7pknrhZKfe4ytJG8oS22MLbX8+FlIYFuijzkaH2h36/PyjZUF1z
	7EUZJOhTIHypPcUoAcqxOOVUKmwet
X-Received: by 2002:adf:e988:0:b0:314:111a:e121 with SMTP id h8-20020adfe988000000b00314111ae121mr1293259wrm.30.1689943311975;
        Fri, 21 Jul 2023 05:41:51 -0700 (PDT)
X-Google-Smtp-Source: APBJJlGgKWQp3xRIZLdqjpfK2v+N15MJ35IUC0zDkCbYcmzkw9dg6olmPqt+y/5EMK37ySdgHGvR9Q==
X-Received: by 2002:adf:e988:0:b0:314:111a:e121 with SMTP id h8-20020adfe988000000b00314111ae121mr1293249wrm.30.1689943311611;
        Fri, 21 Jul 2023 05:41:51 -0700 (PDT)
Date: Fri, 21 Jul 2023 08:41:47 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Cornelia Huck <cohuck@redhat.com>
Cc: Xuan Zhuo <xuanzhuo@linux.alibaba.com>, virtio-dev@lists.oasis-open.org,
	jasowang@redhat.com, Parav Pandit <parav@nvidia.com>
Message-ID: <20230721083327-mutt-send-email-mst@kernel.org>
References: <20220315032402.6088-1-xuanzhuo@linux.alibaba.com>
 <20230712072050-mutt-send-email-mst@kernel.org>
 <1689162241.4383667-1-xuanzhuo@linux.alibaba.com>
 <20230712075319-mutt-send-email-mst@kernel.org>
 <87mt01jp1b.fsf@redhat.com>
 <20230712082616-mutt-send-email-mst@kernel.org>
 <87mszp8nae.fsf@redhat.com>
MIME-Version: 1.0
In-Reply-To: <87mszp8nae.fsf@redhat.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Subject: [virtio-dev] Re: 1.3 and branching (was: [virtio-dev] Re: [PATCH v12] virtio-net:
 support device stats)

On Fri, Jul 21, 2023 at 02:24:57PM +0200, Cornelia Huck wrote:
> On Wed, Jul 12 2023, "Michael S. Tsirkin" <mst@redhat.com> wrote:
> 
> > On Wed, Jul 12, 2023 at 02:24:32PM +0200, Cornelia Huck wrote:
> >> On Wed, Jul 12 2023, "Michael S. Tsirkin" <mst@redhat.com> wrote:
> >> > Yes we were supposed to freeze for 1.3. This change can be merged on a
> >> > main branch after 1.3 forks and is under review.
> >> 
> >> Nod, that's what I would prefer to do. Being merged on virtio-next
> >> should be enough for including device/driver implementations.
> >
> > Except I'd prefer a v1.3 branch instead of a next branch - adding things
> > on the branch should be harder, not easier.
> 
> Just to clarify: What I had planned for 1.3 (and what we already did for
> 1.2) is to fork a -next branch, finish 1.3 on the master branch, and
> then merge -next back into master after we'd be done with 1.3.
> 
> I'm not sure what you mean by "adding things on the branch should be
> harder, not easier" -- I think it is already a bit harder because it is
> a branch :)
> 
> We can of course do a v1.3 branch instead and continue developing on
> master, but shouldn't we then create branches (glorified tags) for the
> older releases as well?

Yea, makes sense.
I think we are all set WRT what we planned to be in 1.3 - right?
Next step is preparing the changelog and packaging it
all as WD, then voting to approve it as a CSD/CSPRD and start
public review.

Have time this week? if not I will get to it next week.

-- 
MST


---------------------------------------------------------------------
To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org

