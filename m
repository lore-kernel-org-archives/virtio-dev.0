Return-Path: <virtio-dev-return-11629-virtio-dev=archiver.kernel.org@lists.oasis-open.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from ws5-mx01.kavi.com (ws5-mx01.kavi.com [34.193.7.191])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2798AC61DA4
	for <virtio-dev@archiver.kernel.org>; Wed, 15 Mar 2023 15:10:06 +0000 (UTC)
Received: from lists.oasis-open.org (oasis.ws5.connectedcommunity.org [10.110.1.242])
	by ws5-mx01.kavi.com (Postfix) with ESMTP id 52B26C6226
	for <virtio-dev@archiver.kernel.org>; Wed, 15 Mar 2023 15:10:05 +0000 (UTC)
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id 2D8F1986408
	for <virtio-dev@archiver.kernel.org>; Wed, 15 Mar 2023 15:10:05 +0000 (UTC)
Received: from host09.ws5.connectedcommunity.org (host09.ws5.connectedcommunity.org [10.110.1.97])
	by lists.oasis-open.org (Postfix) with QMQP
	id 05B809863FC; Wed, 15 Mar 2023 15:10:05 +0000 (UTC)
Mailing-List: contact virtio-dev-help@lists.oasis-open.org; run by ezmlm
List-ID: <virtio-dev.lists.oasis-open.org>
Sender: <virtio-dev@lists.oasis-open.org>
Precedence: bulk
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id DC356986406
	for <virtio-dev@lists.oasis-open.org>; Wed, 15 Mar 2023 15:10:04 +0000 (UTC)
X-Virus-Scanned: amavisd-new at kavi.com
X-MC-Unique: h2_JiXABMZucfcbnrxmpxg-1
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678893001;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=54jYR51/Ik7WGDwNkuMv3TwYfghS8WXDABLdlTKx2SU=;
        b=zmHL3Bq9RwiCEHCko2d8LS4bglEgG+glY2SLm14Uci0j+yVsxL7QNLee3G+z2ouRP7
         6yIUxXrS0SmncBQOVdkVegEjHotBqO2mN3kfDKHX5TQvaAgogNQ/BbFCdOToXtAu730q
         c8sqgbhMZA0pn+zXB9PHdG5JJ0ICO+ePMeswDDZT6LpIYIQwXhmF5KmJVc8lZMbMb40o
         Xz0A8LnHpSeXQKU0mw3CE/m4kuJDu/lNtFIwI2HAHKk6yznWmOYmca5m3CDWluvOKgqm
         Tf1qblRFe1rEVieJqMgjc24JpQOzUsmnT6AGGc5U2nUcblbG11D6obt9yTxCsKBTVgsv
         Pilg==
X-Gm-Message-State: AO0yUKUWrTUHXaWQU8bVgu6Lcu6ncfrwkjgVKx6U2hHdUqxWyQM3g4Y0
	48Z2kkrobsm2x3hA4TtZwhq0CIeFwPAnlx9a2lZfoOMozASiPebMnQTdROmOCXVGwcusExqlzZJ
	HObzW7lc5HzVClAGEUg2ZjzRU1EKK
X-Received: by 2002:a05:600c:4fcf:b0:3eb:246d:7efd with SMTP id o15-20020a05600c4fcf00b003eb246d7efdmr5344568wmq.2.1678893001013;
        Wed, 15 Mar 2023 08:10:01 -0700 (PDT)
X-Google-Smtp-Source: AK7set+gLtHfK3rnDxt0SJ1NOQyAP42tb29k56G59mtCxl7+O/bNODZSJC17bFcnIk97bOlcXtC3zA==
X-Received: by 2002:a05:600c:4fcf:b0:3eb:246d:7efd with SMTP id o15-20020a05600c4fcf00b003eb246d7efdmr5344558wmq.2.1678893000685;
        Wed, 15 Mar 2023 08:10:00 -0700 (PDT)
Date: Wed, 15 Mar 2023 11:09:56 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Heng Qi <hengqi@linux.alibaba.com>
Cc: Parav Pandit <parav@nvidia.com>, virtio-dev@lists.oasis-open.org,
	virtio-comment@lists.oasis-open.org,
	Jason Wang <jasowang@redhat.com>,
	Yuri Benditovich <yuri.benditovich@daynix.com>,
	Cornelia Huck <cohuck@redhat.com>,
	Xuan Zhuo <xuanzhuo@linux.alibaba.com>
Message-ID: <20230315110736-mutt-send-email-mst@kernel.org>
References: <20230306154817.14115-1-hengqi@linux.alibaba.com>
 <c81de233-227c-73c8-a4bd-d43aa374dd86@nvidia.com>
 <e573702a-9a2e-d210-f13a-f0b241442991@linux.alibaba.com>
MIME-Version: 1.0
In-Reply-To: <e573702a-9a2e-d210-f13a-f0b241442991@linux.alibaba.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Subject: [virtio-dev] Re: [PATCH v10] virtio-net: support inner header hash

On Wed, Mar 15, 2023 at 09:19:43PM +0800, Heng Qi wrote:
> > Any encapsulation technology that includes UDP/L4 header likely do not
> > prefer based on the inner header. This is because the outer header src
> > port entropy is added based on the inner header.
> > 
> > I was not able to follow the discussion in v9 that you had with Michael.
> > Did you conclude if this is needed for vxlan too?
> > 
> > If not, for now it may be better to skip vxlan and nvegre as they
> > inherently have unique outer header UDP src port based on the inner
> > header.
> 
> Symmetric hashing ignores the order of the five-tuples when calculating the
> hash, that is, using (a1,a2,p1,p2) and (a2,a1,p2,p1) respectively can
> calculate the same hash.
> There is a scenario that the two directions client1->client2 and
> client2->client1 of the same flow may pass through different tunnels.
> In order to allow the data in two directions to be processed by the same
> CPU, we need to calculate a symmetric hash based on the inner packet header.
> Sorry I didn't mention this earlier just to avoid introducing the concept of
> symmetric hashing.

But the hash is already there in the port. Is it then maybe just
the question of ignoring the IP addresses when hashing?

-- 
MST


---------------------------------------------------------------------
To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org

