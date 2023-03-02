Return-Path: <virtio-dev-return-11402-virtio-dev=archiver.kernel.org@lists.oasis-open.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from ws5-mx01.kavi.com (ws5-mx01.kavi.com [34.193.7.191])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5EF6AC678D4
	for <virtio-dev@archiver.kernel.org>; Thu,  2 Mar 2023 23:38:48 +0000 (UTC)
Received: from lists.oasis-open.org (oasis.ws5.connectedcommunity.org [10.110.1.242])
	by ws5-mx01.kavi.com (Postfix) with ESMTP id 9772F3309F
	for <virtio-dev@archiver.kernel.org>; Thu,  2 Mar 2023 23:38:47 +0000 (UTC)
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id 6EE6C9866D9
	for <virtio-dev@archiver.kernel.org>; Thu,  2 Mar 2023 23:38:47 +0000 (UTC)
Received: from host09.ws5.connectedcommunity.org (host09.ws5.connectedcommunity.org [10.110.1.97])
	by lists.oasis-open.org (Postfix) with QMQP
	id 5BEC3984091; Thu,  2 Mar 2023 23:38:47 +0000 (UTC)
Mailing-List: contact virtio-dev-help@lists.oasis-open.org; run by ezmlm
List-Id: <virtio-dev.lists.oasis-open.org>
Precedence: bulk
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id 492149866AF
	for <virtio-dev@lists.oasis-open.org>; Thu,  2 Mar 2023 23:38:47 +0000 (UTC)
X-Virus-Scanned: amavisd-new at kavi.com
X-MC-Unique: eG7NzZ3aNSO3suoEmctjkg-1
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1677800324;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=04hd6lqGkpZeBZyObZlW8WWMmSbbwQcAeVd1FmazPFk=;
        b=MU8Fo89AF1AKI34MUnLiCZavR93R9Ob0L70UBwVcRunleA5QLzIWJY9jRRK+aD2/ca
         31crQV7TPAyDvDdO8BYW4uYLEuw0SYYsiTDLiOrXZJa0Lxx36owt+zkt7UgQ/GOigXoB
         39knBLSqhDQE2Lwx0tuBc/OLDVTTx0swXsQZvaoP7FNg2JKyo7xsB2IF/o51PnoGS3Ex
         0I9Nyvo+dOkZ/eT/UUWugFw9Ou+97HjU+2m5Vm3ITO6jBVWn5qzaila+d6KxtGEWKT94
         Q2gkV5PgMKun+UdqX7DsCI5o/r6wPh8e9qBq4XVTSVBsmwpumzBk0YNK01MzPu8ojAnS
         8J9w==
X-Gm-Message-State: AO0yUKWYsJK8cqbpy+qA8v/0UORtvKDzyuk26qXK34DHIzFcAK25kxeu
	JD9yqTyPm8DK31n4C8d1yV0gouaFSl0dn6GKm9Lj+8rpZEUZxc1HE51UmkyTyH+lH30wk3qACtD
	6ySPKUETcZ7Wn2EAqPoQ65z6afrfd
X-Received: by 2002:adf:fbc7:0:b0:2cc:4d13:908d with SMTP id d7-20020adffbc7000000b002cc4d13908dmr48467wrs.11.1677800323875;
        Thu, 02 Mar 2023 15:38:43 -0800 (PST)
X-Google-Smtp-Source: AK7set+3rjoBdkNKnXSx+37RI40zPyKw03swp4u9rFb/7RLlnlstFKvWgd5efT9PudxteBGjSVOJ2g==
X-Received: by 2002:adf:fbc7:0:b0:2cc:4d13:908d with SMTP id d7-20020adffbc7000000b002cc4d13908dmr48457wrs.11.1677800323563;
        Thu, 02 Mar 2023 15:38:43 -0800 (PST)
Date: Thu, 2 Mar 2023 18:38:40 -0500
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Parav Pandit <parav@nvidia.com>
Cc: Halil Pasic <pasic@linux.ibm.com>,
	"virtio-dev@lists.oasis-open.org" <virtio-dev@lists.oasis-open.org>,
	"cohuck@redhat.com" <cohuck@redhat.com>,
	"virtio-comment@lists.oasis-open.org" <virtio-comment@lists.oasis-open.org>,
	Shahaf Shuler <shahafs@nvidia.com>,
	Yuri Benditovich <yuri.benditovich@daynix.com>
Message-ID: <20230302183736-mutt-send-email-mst@kernel.org>
References: <20230223054624.168042-1-parav@nvidia.com>
 <20230227123751-mutt-send-email-mst@kernel.org>
 <20230302165216.1293d066.pasic@linux.ibm.com>
 <PH0PR12MB54810632DAE7C0D8BEABC9E9DCB29@PH0PR12MB5481.namprd12.prod.outlook.com>
MIME-Version: 1.0
In-Reply-To: <PH0PR12MB54810632DAE7C0D8BEABC9E9DCB29@PH0PR12MB5481.namprd12.prod.outlook.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Subject: [virtio-dev] Re: [virtio-comment] Re: [PATCH 0/3] Rename queue index to queue
 number

On Thu, Mar 02, 2023 at 04:12:48PM +0000, Parav Pandit wrote:
> 
> 
> > From: virtio-comment@lists.oasis-open.org <virtio-comment@lists.oasis-
> > open.org> On Behalf Of Halil Pasic
> > 
> > On Mon, 27 Feb 2023 12:39:39 -0500
> > "Michael S. Tsirkin" <mst@redhat.com> wrote:
> > 
> > > > This series is on top of [2].
> > > >
> > > > [1] https://github.com/oasis-tcs/virtio-spec/issues/163
> > > > [2]
> > > > https://lists.oasis-open.org/archives/virtio-dev/202302/msg00527.htm
> > > > l
> > >
> > > What about RSS description in net? That says:
> > >
> > > description.tex:Field \field{unclassified_queue} contains the 0-based
> > > index of
> > >
> > > is the index same as vq number? or something different?
> > 
> > It is something different. The full paragraph sound like this
> > 
> > """
> > Field \field{unclassified_queue} contains the 0-based index of the receive
> > virtqueue to place unclassified packets in. Index 0 corresponds to receiveq1.
> > """
> With vqn it can be as simply written as.
> Field \field{unclassified_queue} contains the receive virtqueue number to use for unclassified incoming packets.
> 
> Similarly rss description can be simplified.

Unfortunately this is not what it is. It's actually vqn / 2.

> > Here follows the explanation.
> > 
> > Disclaimer: For a brief math background see [1] and [2].
> > 
> > Here the index set the set of natural numbers (which includes 0, the neutral
> > element for the addition operation).
> > 
> > The indexed set is the set of receive virtqueues, each member of that set is
> > associated with an unique member of the index set.
> > 
> > """
> > \subsection{Virtqueues}\label{sec:Device Types / Network Device / Virtqueues}
> > 
> > \begin{description}
> > \item[0] receiveq1
> > \item[1] transmitq1
> > \item[\ldots]
> > \item[2(N-1)] receiveqN
> > \item[2(N-1)+1] transmitqN
> > \item[2N] controlq
> > \end{description}
> > """
> > 
> > But, as seen above, we happen to also use an other index set for the receive
> > queues of an virtio-net device. I guess the intention is to use these as names, in
> > any case the set is { "receiveq1", "receiveq2", ... } (yes, I'm a little sloppy here).
> > 
> > Thus we can say that:
> > * the virtqueue index 2*(N-1)
> > * the recieve virtqueue index N-1, and the
> > * virtqueue name receiveqN
> > refer to the very same virtqueue (for each N > 0)
> > 
> Receiveq1 is a name to virtuque number (currently index) 0.
> And naming this way doesn't seem to be a problem in the description.
> 
> Section 5.1.2 is liste them already.
> A short line tell about this mapping will suffice.

can't parse this.


> > And it depends on the context which scheme do we use. As far as I remember
> > the names are not a part of any virtio interface. I.e. they are only there for the
> > convenience of the spec and the reader. We could get rid of those. Although
> > the possibility of corresponding to some network device, Linux network device
> > or tooling naming convention is also to consider. But AFAIU Linux uses 0 based
> > indexing for the rx and tx queues. 
> Correct.
> 
> > If the 1 based naming is really just
> > constrained to the spec, we can change it without problem.
> Yes, most changes are trivial I looked at.
>  


---------------------------------------------------------------------
To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org

