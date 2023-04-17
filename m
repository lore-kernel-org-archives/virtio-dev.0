Return-Path: <virtio-dev-return-12253-virtio-dev=archiver.kernel.org@lists.oasis-open.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from ws5-mx01.kavi.com (ws5-mx01.kavi.com [34.193.7.191])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D9F6FC77B70
	for <virtio-dev@archiver.kernel.org>; Mon, 17 Apr 2023 13:22:23 +0000 (UTC)
Received: from lists.oasis-open.org (oasis.ws5.connectedcommunity.org [10.110.1.242])
	by ws5-mx01.kavi.com (Postfix) with ESMTP id 01C8F42B68
	for <virtio-dev@archiver.kernel.org>; Mon, 17 Apr 2023 13:22:23 +0000 (UTC)
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id DD9C4986386
	for <virtio-dev@archiver.kernel.org>; Mon, 17 Apr 2023 13:22:22 +0000 (UTC)
Received: from host09.ws5.connectedcommunity.org (host09.ws5.connectedcommunity.org [10.110.1.97])
	by lists.oasis-open.org (Postfix) with QMQP
	id C4BD098632B; Mon, 17 Apr 2023 13:22:22 +0000 (UTC)
Mailing-List: contact virtio-dev-help@lists.oasis-open.org; run by ezmlm
List-ID: <virtio-dev.lists.oasis-open.org>
Sender: <virtio-dev@lists.oasis-open.org>
Precedence: bulk
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id B17F398634A
	for <virtio-dev@lists.oasis-open.org>; Mon, 17 Apr 2023 13:22:21 +0000 (UTC)
X-Virus-Scanned: amavisd-new at kavi.com
X-MC-Unique: DtksMbKnMLS2DraAAD5XkQ-1
From: Cornelia Huck <cohuck@redhat.com>
To: Alexander Gordeev <alexander.gordeev@opensynergy.com>, Alexandre Courbot
 <acourbot@chromium.org>, Albert Esteve <aesteve@redhat.com>
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
 <eballetb@redhat.com>
In-Reply-To: <39649cbc-f8e3-0ade-f8dc-b46a537710b7@opensynergy.com>
Organization: Red Hat GmbH
References: <20221208072325.2259940-1-acourbot@chromium.org>
 <5fa6dc30-af86-e58c-2d39-fde2836192c3@opensynergy.com>
 <CAPBb6MWqqAFB+g=JZu9-VgZbEJxS3wYaEgA-R_P=OyHRTHy7eQ@mail.gmail.com>
 <8ec36252-97c6-0378-e25b-fc972ea3a66d@opensynergy.com>
 <CAPBb6MVDKfKOyDFPiOL3fRp4Jn6WwMpSZt6V32EJ1CYW_+rw+w@mail.gmail.com>
 <909867c6-b66c-1281-45a7-38fd0aa32123@opensynergy.com>
 <87cz6mnaqk.fsf@redhat.com>
 <CAPBb6MWNfPH+e8=4zUcq2dV-59OdzTYSuN04Cg2rRPWao-nseQ@mail.gmail.com>
 <877cwttw2x.fsf@redhat.com> <87a60kg9rh.fsf@redhat.com>
 <CAPBb6MX+R-bDgJzracbZq6DE7B0WO=rtqS6GE1QDugdrFLryXw@mail.gmail.com>
 <877cvog030.fsf@redhat.com>
 <CAPBb6MWyVoEuXJoKvJhP-5zp-x5WrDwVWe8mxbXbCwyzfgqW1g@mail.gmail.com>
 <CADSE00KD9=2hs5b=fZpTe7XDm3Q3PAmQczGciE=zLBOF3UNLBA@mail.gmail.com>
 <CAPBb6MW6RxdaH_kq6ZsWpP78yGBSP4T6p3E4=O=uKje4P+MiFw@mail.gmail.com>
 <87ttxek6pb.fsf@redhat.com>
 <39649cbc-f8e3-0ade-f8dc-b46a537710b7@opensynergy.com>
User-Agent: Notmuch/0.37 (https://notmuchmail.org)
Date: Mon, 17 Apr 2023 15:22:14 +0200
Message-ID: <87r0sik5ix.fsf@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.3
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain
Subject: Re: [virtio-dev] Re: [RFC PATCH v6] virtio-video: Add virtio video
 device specification

On Mon, Apr 17 2023, Alexander Gordeev <alexander.gordeev@opensynergy.com> wrote:

> Hello Cornelia,
>
> On 17.04.23 14:56, Cornelia Huck wrote:
>> On Sat, Apr 15 2023, Alexandre Courbot <acourbot@chromium.org> wrote:
>>
>>> If nobody strongly objects, I think this can be pushed a bit more
>>> officially. Cornelia, would you consider it for inclusion if I
>>> switched the next version of the specification to use V4L2 as the
>>> host/guest protocol? This may take some more time as I want to confirm
>>> the last details with code, but it should definitely be faster to
>>> merge and to test with a real implementation than our previous
>>> virtio-video attempts.
>> Yes, please do post a new version of this spec; I agree that an existing
>> implementation is really helpful here.
>>
>> [I have proposed July 1st as a "freeze" date for new features for 1.3,
>> with August 1st as an "everything must be in" date; I'd really like
>> virtio-video to be a part of 1.3, if possible :)]
>
> I sent an email minutes ago with an alternative plan. I'd like to
> volunteer to continue the evolutionary changes to virtio-video. I'm
> already working on the v7 draft. I think it will be available next week.
> Then I'll focus on making the driver V4L2 compliant. I think all of this
> is achievable by July 1st. At least the spec part. I think the
> revolutionary changes should be in a separate namespace. The rationale
> is in the longer email. WDYT?

Seems our mails crossed mid-air... I'll go ahead and read your mail (and
probably answer there.) My ultimate goal is to have a spec everyone is
happy with, regardless on how we arrive there.


---------------------------------------------------------------------
To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org

