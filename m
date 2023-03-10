Return-Path: <virtio-dev-return-11598-virtio-dev=archiver.kernel.org@lists.oasis-open.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from ws5-mx01.kavi.com (ws5-mx01.kavi.com [34.193.7.191])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F41A9C64EC4
	for <virtio-dev@archiver.kernel.org>; Fri, 10 Mar 2023 10:51:10 +0000 (UTC)
Received: from lists.oasis-open.org (oasis.ws5.connectedcommunity.org [10.110.1.242])
	by ws5-mx01.kavi.com (Postfix) with ESMTP id 28EA12A888
	for <virtio-dev@archiver.kernel.org>; Fri, 10 Mar 2023 10:51:10 +0000 (UTC)
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id 10F44986720
	for <virtio-dev@archiver.kernel.org>; Fri, 10 Mar 2023 10:51:10 +0000 (UTC)
Received: from host09.ws5.connectedcommunity.org (host09.ws5.connectedcommunity.org [10.110.1.97])
	by lists.oasis-open.org (Postfix) with QMQP
	id EF8BB986719; Fri, 10 Mar 2023 10:51:09 +0000 (UTC)
Mailing-List: contact virtio-dev-help@lists.oasis-open.org; run by ezmlm
List-ID: <virtio-dev.lists.oasis-open.org>
Sender: <virtio-dev@lists.oasis-open.org>
Precedence: bulk
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id DD98998671A
	for <virtio-dev@lists.oasis-open.org>; Fri, 10 Mar 2023 10:51:09 +0000 (UTC)
X-Virus-Scanned: amavisd-new at kavi.com
X-MC-Unique: V0Dx1DFENQeUzR9r8efN-w-1
From: Cornelia Huck <cohuck@redhat.com>
To: Alexandre Courbot <acourbot@chromium.org>
Cc: Alexander Gordeev <alexander.gordeev@opensynergy.com>,
 virtio-dev@lists.oasis-open.org, Keiichi Watanabe <keiichiw@chromium.org>,
 Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>, Marcin Wojtas
 <mwojtas@google.com>,
 Matti =?utf-8?Q?M=C3=B6ll?= <Matti.Moell@opensynergy.com>, Andrew Gazizov
 <andrew.gazizov@opensynergy.com>, Enrico Granata <egranata@google.com>,
 Gustavo Padovan <gustavo.padovan@collabora.com>, Peter Griffin
 <peter.griffin@linaro.org>, =?utf-8?Q?Bart=C5=82omiej?= Grzesik
 <bag@semihalf.com>, Tomasz
 Figa <tfiga@chromium.org>, Daniel Almeida <daniel.almeida@collabora.com>
In-Reply-To: <877cwttw2x.fsf@redhat.com>
Organization: Red Hat GmbH
References: <20221208072325.2259940-1-acourbot@chromium.org>
 <5fa6dc30-af86-e58c-2d39-fde2836192c3@opensynergy.com>
 <CAPBb6MWqqAFB+g=JZu9-VgZbEJxS3wYaEgA-R_P=OyHRTHy7eQ@mail.gmail.com>
 <8ec36252-97c6-0378-e25b-fc972ea3a66d@opensynergy.com>
 <CAPBb6MVDKfKOyDFPiOL3fRp4Jn6WwMpSZt6V32EJ1CYW_+rw+w@mail.gmail.com>
 <909867c6-b66c-1281-45a7-38fd0aa32123@opensynergy.com>
 <87cz6mnaqk.fsf@redhat.com>
 <CAPBb6MWNfPH+e8=4zUcq2dV-59OdzTYSuN04Cg2rRPWao-nseQ@mail.gmail.com>
 <877cwttw2x.fsf@redhat.com>
User-Agent: Notmuch/0.37 (https://notmuchmail.org)
Date: Fri, 10 Mar 2023 11:50:58 +0100
Message-ID: <87a60kg9rh.fsf@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.6
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain
Subject: Re: [virtio-dev] Re: [RFC PATCH v6] virtio-video: Add virtio video
 device specification

On Tue, Feb 07 2023, Cornelia Huck <cohuck@redhat.com> wrote:

> On Tue, Feb 07 2023, Alexandre Courbot <acourbot@chromium.org> wrote:
>
>> On Mon, Feb 6, 2023 at 11:13 PM Cornelia Huck <cohuck@redhat.com> wrote:
>>> I hope we can sort this out soon -- I guess I'm not the only one who is
>>> anxious about this spec moving forward :) Please let me know if I can
>>> help in any way.
>>
>> I'll try to address Alexander's points in more detail, but I am not
>> seeing any blocking issue with using the V4L2 UAPI as the basis for
>> virtio-video (we are working on a small proof-of-concept and things
>> are going smoothly so far).
>
> Great to hear, looking forward to it!

Quick question: Is there any git repo or similar where interested
parties can follow along? It would be great to have virtio-video in 1.3;
if you have some idea on when it might be ready, we could come up with a
schedule to accommodate that.


---------------------------------------------------------------------
To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org

