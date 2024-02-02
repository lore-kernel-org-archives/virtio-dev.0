Return-Path: <virtio-dev-return-14295-virtio-dev=archiver.kernel.org@lists.oasis-open.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from ws5-mx01.kavi.com (ws5-mx01.kavi.com [34.193.7.191])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 944E9C47DB3
	for <virtio-dev@archiver.kernel.org>; Fri,  2 Feb 2024 12:45:29 +0000 (UTC)
Received: from lists.oasis-open.org (oasis.ws5.connectedcommunity.org [10.110.1.242])
	by ws5-mx01.kavi.com (Postfix) with ESMTP id BDB5B2B013
	for <virtio-dev@archiver.kernel.org>; Fri,  2 Feb 2024 12:45:28 +0000 (UTC)
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id 9E0129868B3
	for <virtio-dev@archiver.kernel.org>; Fri,  2 Feb 2024 12:45:28 +0000 (UTC)
Received: from host09.ws5.connectedcommunity.org (host09.ws5.connectedcommunity.org [10.110.1.97])
	by lists.oasis-open.org (Postfix) with QMQP
	id 79764986547; Fri,  2 Feb 2024 12:45:28 +0000 (UTC)
Mailing-List: contact virtio-dev-help@lists.oasis-open.org; run by ezmlm
List-ID: <virtio-dev.lists.oasis-open.org>
Sender: <virtio-dev@lists.oasis-open.org>
Precedence: bulk
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id 651499868B0
	for <virtio-dev@lists.oasis-open.org>; Fri,  2 Feb 2024 12:45:28 +0000 (UTC)
X-Virus-Scanned: amavisd-new at kavi.com
X-MC-Unique: iwndiQb0MpywVP_CBbUWuQ-1
From: Cornelia Huck <cohuck@redhat.com>
To: Mikhail Golubev-Ciuchea <mikhail.golubev-ciuchea@opensynergy.com>,
 virtio-comment@lists.oasis-open.org, virtio-dev@lists.oasis-open.org,
 linux-can@vger.kernel.org
Cc: Harald Mommer <harald.mommer@opensynergy.com>
In-Reply-To: <87ttnemuon.fsf@redhat.com>
Organization: "Red Hat GmbH, Sitz: Werner-von-Siemens-Ring 12, D-85630
 Grasbrunn, Handelsregister: Amtsgericht =?utf-8?Q?M=C3=BCnchen=2C?= HRB
 153243,
 =?utf-8?Q?Gesch=C3=A4ftsf=C3=BChrer=3A?= Ryan Barnhart, Charles Cachera,
 Michael O'Neill, Amy
 Ross"
References: <20230609142243.199074-1-Mikhail.Golubev-Ciuchea@opensynergy.com>
 <ebc57e36-d822-4264-a763-b530482b2669@opensynergy.com>
 <87ttnemuon.fsf@redhat.com>
User-Agent: Notmuch/0.37 (https://notmuchmail.org)
Date: Fri, 02 Feb 2024 13:45:14 +0100
Message-ID: <87eddvjaqt.fsf@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.6
Subject: [virtio-dev] Re: [virtio-comment] [RFC PATCH v3] virtio-can: Device specification.

On Mon, Jan 15 2024, Cornelia Huck <cohuck@redhat.com> wrote:

> On Mon, Jan 08 2024, Mikhail Golubev-Ciuchea <mikhail.golubev-ciuchea@opensynergy.com> wrote:
>
>> Hi all!
>>
>> I kindly request a vote.
>>
>> Fixes: https://github.com/oasis-tcs/virtio-spec/issues/186
>
> Oh, that has been a while... I believe that this still fits on top,
> although it has conflicts with virtio-spi, but nothing that a bit of
> fiddling can't sort out.
>
> The main problem is that we're currently in a bit of an unfortunate
> situation regarding voting: There's still a twice-postponed migration of
> the OASIS infrastructure coming up, and I don't want to risk the voting
> period being affected by an outage... hopefully we'll get a new schedule
> soon.
>
> In the meanwhile, if anyone could spare a few cycles looking at this,
> it'd be appreciated. Nothing jumped out at me, but I'm not a CAN expert;
> I'd be happy to open voting but for the looming migration issue.

OK, I'll just go ahead and open a vote, no reason to drag this out
further, and hopefully we're done by the time the migration _really_
happens...


---------------------------------------------------------------------
To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org

