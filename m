Return-Path: <virtio-dev-return-12749-virtio-dev=archiver.kernel.org@lists.oasis-open.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from ws5-mx01.kavi.com (ws5-mx01.kavi.com [34.193.7.191])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0C99AC77B7D
	for <virtio-dev@archiver.kernel.org>; Wed, 17 May 2023 16:28:38 +0000 (UTC)
Received: from lists.oasis-open.org (oasis.ws5.connectedcommunity.org [10.110.1.242])
	by ws5-mx01.kavi.com (Postfix) with ESMTP id 296A1603CE
	for <virtio-dev@archiver.kernel.org>; Wed, 17 May 2023 16:28:38 +0000 (UTC)
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id F1CB79866F8
	for <virtio-dev@archiver.kernel.org>; Wed, 17 May 2023 16:28:37 +0000 (UTC)
Received: from host09.ws5.connectedcommunity.org (host09.ws5.connectedcommunity.org [10.110.1.97])
	by lists.oasis-open.org (Postfix) with QMQP
	id D316A9865D8; Wed, 17 May 2023 16:28:37 +0000 (UTC)
Mailing-List: contact virtio-dev-help@lists.oasis-open.org; run by ezmlm
List-ID: <virtio-dev.lists.oasis-open.org>
Sender: <virtio-dev@lists.oasis-open.org>
Precedence: bulk
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id BFE7C9865ED
	for <virtio-dev@lists.oasis-open.org>; Wed, 17 May 2023 16:28:37 +0000 (UTC)
X-Virus-Scanned: amavisd-new at kavi.com
X-MC-Unique: ylk_rAu2PtKjQwmpliUc2Q-1
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
In-Reply-To: <7c44f2e4-1138-ff69-7cff-11edaec2ecbb@opensynergy.com>
Organization: Red Hat GmbH
References: <20221208072325.2259940-1-acourbot@chromium.org>
 <877cwttw2x.fsf@redhat.com> <87a60kg9rh.fsf@redhat.com>
 <CAPBb6MX+R-bDgJzracbZq6DE7B0WO=rtqS6GE1QDugdrFLryXw@mail.gmail.com>
 <877cvog030.fsf@redhat.com>
 <CAPBb6MWyVoEuXJoKvJhP-5zp-x5WrDwVWe8mxbXbCwyzfgqW1g@mail.gmail.com>
 <ca84a8f5-71ed-aea8-5751-60403d167283@opensynergy.com>
 <CAPBb6MUDWVK87_kGFen36tDJQoR-Les6djcKVihjuTKQBjweEQ@mail.gmail.com>
 <b5c9d69a-fbec-8046-225f-bdb5850bbd54@opensynergy.com>
 <CAPBb6MUFbZzTTPqztVXQpcPN+PtqrmCoyaD5dySYdP_7EbRDdQ@mail.gmail.com>
 <11372cda-a766-ef50-45d7-ed637b72a31c@opensynergy.com>
 <CAPBb6MVRPn6dM8ap9uDvX_ZHdHGvooq+LB7UGDaWBEuUtK3x=A@mail.gmail.com>
 <cbed366a-7f12-8642-18ef-350981279241@opensynergy.com>
 <87a5ylzf34.fsf@redhat.com>
 <8ee0075c-2604-9fc2-27c0-f68e32e2a923@opensynergy.com>
 <CAPBb6MWePYtAvEzrL2VD7ssjaJfR+JENJp33FbbwQJxxQSqPWQ@mail.gmail.com>
 <c3518814-022d-9c59-7209-5cb236f61176@opensynergy.com>
 <CAPBb6MXGk-j9_hdU0DCSWoo=cUOFSxRjmLyoXObC8u2BmKeRdg@mail.gmail.com>
 <7c44f2e4-1138-ff69-7cff-11edaec2ecbb@opensynergy.com>
User-Agent: Notmuch/0.37 (https://notmuchmail.org)
Date: Wed, 17 May 2023 18:28:29 +0200
Message-ID: <87y1lmx6qa.fsf@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.2
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain
Subject: Re: [virtio-dev] Re: [RFC PATCH v6] virtio-video: Add virtio video
 device specification

>>> I also hope to be able to update virtio-video at a faster pace. Please
>>> let me try.
>>
>> Please hold on a bit - there are two things here.
>>
>> 1) I'd like to settle the virtio-v4l2/virtio-video argument first to
>> make sure we don't get two things clashing head-on. As far as codecs
>> are concerned we certainly don't need both. Cornelia, I think we'll
>> need you to make a call on this, or at least tell us what you need to
>> make the call. If it helps I can send a draft of what the virtio-v4l2
>> spec would look like, it should be relatively short.
>>
>> 2) I (and other ChromeOS contributors) have been driving this spec so
>> far and while I think virtio-v4l2 is a better solution, I have not
>> said I would give up on virtio-video if virtio-v4l2 was not adopted
>> and will keep iterating on it in that case.
>
> It actually very much looks like you gave up. I mean, you developed it
> for years, and now you'd like to throw it away. Well, I meant something
> like "please have some faith in my ability to update virtio-video at a
> faster pace". I think I already have the permission to continue the
> development. You know, OpenSynergy also spent some time on the
> virtio-video. This includes the draft v1 version and the V4L2 driver. I
> think this was kind of an informal agreement between us, that you do the
> spec and we do the driver. It didn't work well enough since draft v4, I
> think. Now as our interests are not aligned anymore, it is fine to
> continue separately. I'm not going to wait until you change your mind on
> virtio-v4l2. Obviously you're very busy with it right now. If I stop and
> wait now, we won't have the video device in the 1.3 release for sure. I
> think when we are ready to develop virtio-video together again, we'll
> need a better agreement.

Please, can we just calm down here? This thread is painful to read
already, and pointing at each other is not going to help us to come up
with something that is generally agreeable. In the end, I want _a_ spec,
and I don't really have a horse in V4L2 vs. video race, but having to
dig through all of this in the hope of moderating things is just
impossible if you're arguing in circles, and much of it seemingly being
a rehashing about who said/did something or not.

> That said, I very much appreciate your efforts with the spec. It
> definitely received a lot of improvements.


---------------------------------------------------------------------
To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org

