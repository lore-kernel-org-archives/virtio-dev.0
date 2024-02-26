Return-Path: <virtio-dev-return-14356-virtio-dev=archiver.kernel.org@lists.oasis-open.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from ws5-mx01.kavi.com (ws5-mx01.kavi.com [34.193.7.191])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 71C45C54E49
	for <virtio-dev@archiver.kernel.org>; Mon, 26 Feb 2024 12:36:53 +0000 (UTC)
Received: from lists.oasis-open.org (oasis.ws5.connectedcommunity.org [10.110.1.242])
	by ws5-mx01.kavi.com (Postfix) with ESMTP id C51F378142
	for <virtio-dev@archiver.kernel.org>; Mon, 26 Feb 2024 12:36:52 +0000 (UTC)
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id BCFB4986478
	for <virtio-dev@archiver.kernel.org>; Mon, 26 Feb 2024 12:36:52 +0000 (UTC)
Received: from host09.ws5.connectedcommunity.org (host09.ws5.connectedcommunity.org [10.110.1.97])
	by lists.oasis-open.org (Postfix) with QMQP
	id B1FE3986364; Mon, 26 Feb 2024 12:36:52 +0000 (UTC)
Mailing-List: contact virtio-dev-help@lists.oasis-open.org; run by ezmlm
List-ID: <virtio-dev.lists.oasis-open.org>
Sender: <virtio-dev@lists.oasis-open.org>
Precedence: bulk
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id A2B7398635B
	for <virtio-dev@lists.oasis-open.org>; Mon, 26 Feb 2024 12:36:49 +0000 (UTC)
X-Virus-Scanned: amavisd-new at kavi.com
X-MC-Unique: vpmPKEoUP32DJ8JW_UvdYQ-1
From: Cornelia Huck <cohuck@redhat.com>
To: Marc Kleine-Budde <mkl@pengutronix.de>, Matias Ezequiel Vara Larsen
 <mvaralar@redhat.com>
Cc: Mikhail Golubev-Ciuchea <mikhail.golubev-ciuchea@opensynergy.com>,
 virtio-comment@lists.oasis-open.org, virtio-dev@lists.oasis-open.org,
 linux-can@vger.kernel.org, Harald Mommer <harald.mommer@opensynergy.com>
In-Reply-To: <20240221-juggling-uproar-9518b4901f41-mkl@pengutronix.de>
Organization: "Red Hat GmbH, Sitz: Werner-von-Siemens-Ring 12, D-85630
 Grasbrunn, Handelsregister: Amtsgericht =?utf-8?Q?M=C3=BCnchen=2C?= HRB
 153243,
 =?utf-8?Q?Gesch=C3=A4ftsf=C3=BChrer=3A?= Ryan Barnhart, Charles Cachera,
 Michael O'Neill, Amy
 Ross"
References: <20230609142243.199074-1-Mikhail.Golubev-Ciuchea@opensynergy.com>
 <ebc57e36-d822-4264-a763-b530482b2669@opensynergy.com>
 <ZdXShopKyMYPTUva@fedora>
 <20240221-acts-decade-76d3d69e8e4d-mkl@pengutronix.de>
 <ZdX3xgM36iOVhr3V@fedora>
 <20240221-juggling-uproar-9518b4901f41-mkl@pengutronix.de>
User-Agent: Notmuch/0.37 (https://notmuchmail.org)
Date: Mon, 26 Feb 2024 13:36:40 +0100
Message-ID: <877circsh3.fsf@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.10
Subject: Re: [virtio-dev] Re: [virtio-comment] [RFC PATCH v3] virtio-can:
 Device specification.

On Wed, Feb 21 2024, Marc Kleine-Budde <mkl@pengutronix.de> wrote:

> On 21.02.2024 14:16:54, Matias Ezequiel Vara Larsen wrote:
>> On Wed, Feb 21, 2024 at 01:49:31PM +0100, Marc Kleine-Budde wrote:
>> > On 21.02.2024 11:37:58, Matias Ezequiel Vara Larsen wrote:
>> > > > > +The length of the \field{sdu} is determined by the \field{length}.
>> > > > > +
>> > > > > +The type of a CAN message identifier is determined by \field{flags}. The
>> > > > > +3 most significant bits of \field{can_id} do not bear the information
>> > > > > +about the type of the CAN message identifier and are 0.
>> > > > > +
>> > > > > +The device MUST reject any CAN frame type for which support has not been
>> > > > > +negotiated with VIRTIO_CAN_RESULT_NOT_OK in \field{result} and MUST NOT
>> > > > > +schedule the message for transmission. A CAN frame with an undefined bit
>> > > > > +set in \field{flags} is treated like a CAN frame for which support has
>> > > > > +not been negotiated.
>> > > > > +
>> > > > > +The device MUST reject any CAN frame for which \field{can_id} or
>> > > > > +\field{sdu} length are out of range or the CAN controller is in an
>> > > > > +invalid state with VIRTIO_CAN_RESULT_NOT_OK in \field{result} and MUST
>> > > > > +NOT schedule the message for transmission.
>> > > > > +
>> > > I am not very familiar with CAN but how does the device figure out that
>> > > the can_id is out of range?
>> > 
>> > In classical CAN we have the standard CAN frames, which have an 11 bit
>> > ID, and there are extended CAN frames, which have 29 bits ID. Extended
>> > frames are signaled with VIRTIO_CAN_FLAGS_EXTENDED set.
>> > 
>> > So if a standard frame uses more than 11 Bits of CAN-ID, it's considered
>> > out of range.
>
> Another option would be an extended frame (VIRTIO_CAN_FLAGS_EXTENDED
> set) and using more than 29 bits.
>
>> Thanks Marc for the explanation. Do you think that it would be
>> worthwhile to add that to the spec at some point?
>
> Yes that makes sense as it clarifies what's meant by out of range for
> CAN-IDs, for the valid length a reference to
> \item[VIRTIO_CAN_F_CAN_CLASSIC (0)] and \item[VIRTIO_CAN_F_CAN_FD (1)]
> might be added.

[virtio mailing lists are supposedly down for migration right now, I
hope there's some kind of backfill happening later...]

If the question comes up, it does make sense to add a
clarification... as the virtio-can spec is already voted upon and
merged, we'd need a patch on top. Not sure if it would qualify as an
editorial update or a vote would be needed, best to see it first :)


---------------------------------------------------------------------
To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org

