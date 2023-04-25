Return-Path: <virtio-dev-return-12411-virtio-dev=archiver.kernel.org@lists.oasis-open.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from ws5-mx01.kavi.com (ws5-mx01.kavi.com [34.193.7.191])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EF69DC77B61
	for <virtio-dev@archiver.kernel.org>; Tue, 25 Apr 2023 16:05:40 +0000 (UTC)
Received: from lists.oasis-open.org (oasis.ws5.connectedcommunity.org [10.110.1.242])
	by ws5-mx01.kavi.com (Postfix) with ESMTP id 1B26B2AC49
	for <virtio-dev@archiver.kernel.org>; Tue, 25 Apr 2023 16:05:40 +0000 (UTC)
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id E9FDA9865E2
	for <virtio-dev@archiver.kernel.org>; Tue, 25 Apr 2023 16:05:39 +0000 (UTC)
Received: from host09.ws5.connectedcommunity.org (host09.ws5.connectedcommunity.org [10.110.1.97])
	by lists.oasis-open.org (Postfix) with QMQP
	id C781F98644A; Tue, 25 Apr 2023 16:05:39 +0000 (UTC)
Mailing-List: contact virtio-dev-help@lists.oasis-open.org; run by ezmlm
List-ID: <virtio-dev.lists.oasis-open.org>
Sender: <virtio-dev@lists.oasis-open.org>
Precedence: bulk
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id 8F4FA98644B
	for <virtio-dev@lists.oasis-open.org>; Tue, 25 Apr 2023 16:04:46 +0000 (UTC)
X-Virus-Scanned: amavisd-new at kavi.com
X-MC-Unique: hacMUEzcOf-tiI_UqkpY3A-1
From: Cornelia Huck <cohuck@redhat.com>
To: Alexander Gordeev <alexander.gordeev@opensynergy.com>, Alexandre Courbot
 <acourbot@chromium.org>
Cc: virtio-dev@lists.oasis-open.org, Keiichi Watanabe
 <keiichiw@chromium.org>, Alex =?utf-8?Q?Benn=C3=A9e?=
 <alex.bennee@linaro.org>, Marcin
 Wojtas <mwojtas@google.com>, Matti =?utf-8?Q?M=C3=B6ll?=
 <Matti.Moell@opensynergy.com>,
 Andrew Gazizov <andrew.gazizov@opensynergy.com>, Enrico Granata
 <egranata@google.com>, Gustavo Padovan <gustavo.padovan@collabora.com>,
 Peter Griffin <peter.griffin@linaro.org>, =?utf-8?Q?Bart=C5=82omiej?=
 Grzesik
 <bag@semihalf.com>, Tomasz Figa <tfiga@chromium.org>, Daniel Almeida
 <daniel.almeida@collabora.com>, Enric Balletbo i Serra
 <eballetb@redhat.com>, Albert Esteve <aesteve@redhat.com>
In-Reply-To: <590378d1-83e0-b058-7eeb-2dbe5963670e@opensynergy.com>
Organization: Red Hat GmbH
References: <20221208072325.2259940-1-acourbot@chromium.org>
 <8ec36252-97c6-0378-e25b-fc972ea3a66d@opensynergy.com>
 <CAPBb6MVDKfKOyDFPiOL3fRp4Jn6WwMpSZt6V32EJ1CYW_+rw+w@mail.gmail.com>
 <909867c6-b66c-1281-45a7-38fd0aa32123@opensynergy.com>
 <87cz6mnaqk.fsf@redhat.com>
 <CAPBb6MWNfPH+e8=4zUcq2dV-59OdzTYSuN04Cg2rRPWao-nseQ@mail.gmail.com>
 <877cwttw2x.fsf@redhat.com> <87a60kg9rh.fsf@redhat.com>
 <CAPBb6MX+R-bDgJzracbZq6DE7B0WO=rtqS6GE1QDugdrFLryXw@mail.gmail.com>
 <877cvog030.fsf@redhat.com>
 <CAPBb6MWyVoEuXJoKvJhP-5zp-x5WrDwVWe8mxbXbCwyzfgqW1g@mail.gmail.com>
 <ca84a8f5-71ed-aea8-5751-60403d167283@opensynergy.com>
 <CAPBb6MUDWVK87_kGFen36tDJQoR-Les6djcKVihjuTKQBjweEQ@mail.gmail.com>
 <b5c9d69a-fbec-8046-225f-bdb5850bbd54@opensynergy.com>
 <87o7nmk1rs.fsf@redhat.com>
 <96978ce8-0837-2e08-f5ca-66587807798b@opensynergy.com>
 <CAPBb6MUHXh0XYLH=8anWLNQaS+p6_VhMRki+qSqFQGeYQzBSSA@mail.gmail.com>
 <2d5df33a-c246-81ee-92e7-a44712600e62@opensynergy.com>
 <590378d1-83e0-b058-7eeb-2dbe5963670e@opensynergy.com>
User-Agent: Notmuch/0.37 (https://notmuchmail.org)
Date: Tue, 25 Apr 2023 18:04:38 +0200
Message-ID: <87354okkx5.fsf@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.4
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain
Subject: Re: [virtio-dev] Re: [RFC PATCH v6] virtio-video: Add virtio video
 device specification


[I'm replying here, as that seems to be the last message in the thread,
and my reply hopefully catches everyone interested here.]

To do a very high level summary, we have (at least) two use cases for
virtio-video, that unfortunately have quite different requirements. Both
want to encode/decode video, but in different environments.

- The "restricted" case: Priority is on security, and the attack surface
  should be kept as small as possible, for example, by avoiding unneded
  complexity in the interface. Fancy allocations and management should
  be avoided. The required functionality is also quite clearly defined.
- The "feature-rich" case: Priority is on enabling features, and being
  able to re-use existing V4L2 support is considered a big plus. Both
  device and driver implementations will be implemented in a full OS
  environment, so all kind of helpers are already available.

(This is not to say that one case does not care about functionality or
security; it's mostly a case of different priorities and environments.)

I had been hoping that it would be possible to find kind of a common
ground between the two cases, but reading the thread, I'm not quite as
hopeful anymore... if we really don't manage to find an approach to make
the different requirements co-exist, a separate virtio-v4l2 device might
be the way to go -- but I've not totally given up hope yet.

Some remarks from my side:

- I'm not totally convinced that counting words is always a good proxy
  for complexity -- an interface might be simple on paper, but if the
  actual implementation would need to be quite involved to get it right,
  we'd again have a lot of opportunity for mistakes.
- How much of v4l2 does actually need to be in the device specification
  for a driver to make potentially good use of it? Sure, being able to
  directly map to v4l2 really gives a huge benefit, but is there a way
  to extract a subset that's not too complex, but can be easily wrapped
  for interfacing with v4l2? (Both interface and functionality wise.)
  Even if that means that a driver would need to implement some kind of
  shim, a layer that easily maps to v4l2 concepts would still be much
  easier to implement than one that needs to map two quite different
  interfaces. [I'm really relying on the good judgement of people
  familiar with the interfaces here :)]
- To which extent does security need to be baked into the device
  specification? We should avoid footguns, and avoiding needless
  complication is also a good idea, but while every new functionality
  means more attack surface, it also enables more use cases. That
  tension is hard to resolve; how much of it can we alleviate by making
  things optional?

I hope I have not muddied the waters here, but I'd really like to see an
agreement on how to continue (with two different devices, if there is
really no other way.)


---------------------------------------------------------------------
To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org

