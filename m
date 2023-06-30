Return-Path: <virtio-dev-return-13184-virtio-dev=archiver.kernel.org@lists.oasis-open.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from ws5-mx01.kavi.com (ws5-mx01.kavi.com [34.193.7.191])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8B11DEB64DD
	for <virtio-dev@archiver.kernel.org>; Fri, 30 Jun 2023 08:47:41 +0000 (UTC)
Received: from lists.oasis-open.org (oasis.ws5.connectedcommunity.org [10.110.1.242])
	by ws5-mx01.kavi.com (Postfix) with ESMTP id 0423F2A837
	for <virtio-dev@archiver.kernel.org>; Fri, 30 Jun 2023 08:47:41 +0000 (UTC)
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id EA52A9866FC
	for <virtio-dev@archiver.kernel.org>; Fri, 30 Jun 2023 08:47:40 +0000 (UTC)
Received: from host09.ws5.connectedcommunity.org (host09.ws5.connectedcommunity.org [10.110.1.97])
	by lists.oasis-open.org (Postfix) with QMQP
	id DE8239866EB; Fri, 30 Jun 2023 08:47:40 +0000 (UTC)
Mailing-List: contact virtio-dev-help@lists.oasis-open.org; run by ezmlm
List-ID: <virtio-dev.lists.oasis-open.org>
Sender: <virtio-dev@lists.oasis-open.org>
Precedence: bulk
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id CD4969866EC
	for <virtio-dev@lists.oasis-open.org>; Fri, 30 Jun 2023 08:47:40 +0000 (UTC)
X-Virus-Scanned: amavisd-new at kavi.com
X-MC-Unique: n4-rObVrMsqjnyzFBvRWcQ-1
From: Cornelia Huck <cohuck@redhat.com>
To: "Michael S. Tsirkin" <mst@redhat.com>, Parav Pandit <parav@nvidia.com>
Cc: "virtio@lists.oasis-open.org" <virtio@lists.oasis-open.org>,
 "virtio-comment@lists.oasis-open.org"
 <virtio-comment@lists.oasis-open.org>, "virtio-dev@lists.oasis-open.org"
 <virtio-dev@lists.oasis-open.org>
In-Reply-To: <20230629153345-mutt-send-email-mst@kernel.org>
Organization: Red Hat GmbH
References: <87edoyqvnu.fsf@redhat.com>
 <20230407071926-mutt-send-email-mst@kernel.org>
 <87r0spjct2.fsf@redhat.com>
 <PH0PR12MB54819136AEC54AA081DD395ADC25A@PH0PR12MB5481.namprd12.prod.outlook.com>
 <20230629153345-mutt-send-email-mst@kernel.org>
User-Agent: Notmuch/0.37 (https://notmuchmail.org)
Date: Fri, 30 Jun 2023 10:47:33 +0200
Message-ID: <877crl49qy.fsf@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.2
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain
Subject: [virtio-dev] Re: [virtio-comment] [RFC] virtio 1.3 schedule

On Thu, Jun 29 2023, "Michael S. Tsirkin" <mst@redhat.com> wrote:

> On Thu, Jun 29, 2023 at 05:41:34PM +0000, Parav Pandit wrote:
>> Hi Cornelia, Michael,
>> 
>> > From: virtio-comment@lists.oasis-open.org <virtio-comment@lists.oasis-
>> > open.org> On Behalf Of Cornelia Huck
>> > Sent: Wednesday, April 12, 2023 12:17 PM
>> 
>> > >> - July 1st 2023: enter feature freeze; all proposed changes must at
>> > >>   least have an open github issue that refers to a proposal on-list
>> > >> - August 1st 2023: enter change freeze; everything needs to have been
>> > >>   voted upon (i.e. we can start with preparations for a release like
>> > >>   compiling the change log)
>> > >> - at the same time, fork virtio-next, which can be used for development
>> > >>   while we're working on the release
>> > >> - August/September 2023: prepare draft, initiate initial voting etc.
>> > >
>> > > Hmm looks like you forgot a 30 day the public review period (or is
>> > > that included in the "etc"? ).  During this period we will likely
>> > > receive review comments which we have to address. Should the changes
>> > > turn out to be material, another public review period will be required.
>> > > Let's spell it out please.
>> > 
>> > Yeah, that's what I meant with "etc"... let's make this:
>> > 
>> > - August 2023: prepare draft, aim to have it ready and voted upon by
>> >   August 31 the latest (preferrably earlier)
>> > - September 2023: public review period (30 days)
>> > - October 2023: another public review period, if needed; otherwise, get
>> >   comittee specification ready and voted upon
>> > - October (maybe November, if we're running late) 2023: virtio 1.3
>> >   released
>> > 
>> > The most important dates are feature freeze on Jul 1 and change freeze on Aug
>> > 1, I guess; for the rest, we depend on whether people are out on PTO, which
>> > kind of feedback we get, etc. -- but as long as we release
>> > 1.3 in 2023, I'll be happy enough.
>> 
>> We have two extension features that has gone through several reviews and are in advance stage (and also late) for 1.3. :)
>> 
>> 1. inner hash v19, rolling to v20 anytime this week. 1 Patch.
>> [1] https://lists.oasis-open.org/archives/virtio-comment/202306/msg00490.html
>> 
>> 2. first user of aq for legacy access at v7.
>> 2 patches. First 2 are Fixes.
>> [2] https://lists.oasis-open.org/archives/virtio-comment/202306/msg00491.html
>> 
>> Both need few more days of review and vote.
>> Shall we please have few days in July for them so that it can be part of 1.3? 
>> or whole July is needed to prepare the draft spec?
>
> I think it's not too bad, projects that do releases every couple of
> months can afford to be strict, we do them ones a year and a half
> it makes sense to be flexible.

Yes, my only concern is to avoid slipping too badly -- and the "feature
freeze" period was actually intended to give us some time to wrap up
outstanding features.

For the inner header hash, I see there's already an issue (#173), so
it's good. I have not followed the aq legacy access feature -- if
everyone agrees that we should be able to vote on it in July, we should
have an issue for it as well (I cannot find one just by looking at
titles.)

Any other features that people are aware of?


---------------------------------------------------------------------
To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org

