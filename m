Return-Path: <virtio-dev-return-12248-virtio-dev=archiver.kernel.org@lists.oasis-open.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from ws5-mx01.kavi.com (ws5-mx01.kavi.com [34.193.7.191])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D0E49C77B76
	for <virtio-dev@archiver.kernel.org>; Mon, 17 Apr 2023 08:47:57 +0000 (UTC)
Received: from lists.oasis-open.org (oasis.ws5.connectedcommunity.org [10.110.1.242])
	by ws5-mx01.kavi.com (Postfix) with ESMTP id 2272F41EEE
	for <virtio-dev@archiver.kernel.org>; Mon, 17 Apr 2023 08:47:57 +0000 (UTC)
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id 1DEBB9863EA
	for <virtio-dev@archiver.kernel.org>; Mon, 17 Apr 2023 08:47:57 +0000 (UTC)
Received: from host09.ws5.connectedcommunity.org (host09.ws5.connectedcommunity.org [10.110.1.97])
	by lists.oasis-open.org (Postfix) with QMQP
	id 1222898632B; Mon, 17 Apr 2023 08:47:57 +0000 (UTC)
Mailing-List: contact virtio-dev-help@lists.oasis-open.org; run by ezmlm
List-ID: <virtio-dev.lists.oasis-open.org>
Sender: <virtio-dev@lists.oasis-open.org>
Precedence: bulk
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id 00605986353
	for <virtio-dev@lists.oasis-open.org>; Mon, 17 Apr 2023 08:47:53 +0000 (UTC)
X-Virus-Scanned: amavisd-new at kavi.com
X-MC-Unique: PsfEpbn_MCuj5Y2zT_eZyA-1
From: Cornelia Huck <cohuck@redhat.com>
To: "Michael S. Tsirkin" <mst@redhat.com>, Halil Pasic <pasic@linux.ibm.com>
Cc: Parav Pandit <parav@nvidia.com>, "virtio-dev@lists.oasis-open.org"
 <virtio-dev@lists.oasis-open.org>, "sgarzare@redhat.com"
 <sgarzare@redhat.com>, "virtio-comment@lists.oasis-open.org"
 <virtio-comment@lists.oasis-open.org>, Shahaf Shuler <shahafs@nvidia.com>
In-Reply-To: <20230417024402-mutt-send-email-mst@kernel.org>
Organization: Red Hat GmbH
References: <20230405010657.612529-1-parav@nvidia.com>
 <20230405010657.612529-4-parav@nvidia.com>
 <20230405012723-mutt-send-email-mst@kernel.org>
 <PH0PR12MB5481C1EC27F79A87218C3767DC909@PH0PR12MB5481.namprd12.prod.outlook.com>
 <20230405172731.561890b1.pasic@linux.ibm.com>
 <PH0PR12MB54819AFEDBFEC41CACA0CF92DC909@PH0PR12MB5481.namprd12.prod.outlook.com>
 <20230407073308-mutt-send-email-mst@kernel.org>
 <87ile2kdav.fsf@redhat.com>
 <PH0PR12MB54812C754ED9063E34E06E1BDC9A9@PH0PR12MB5481.namprd12.prod.outlook.com>
 <20230417051844.70ba47cc.pasic@linux.ibm.com>
 <20230417024402-mutt-send-email-mst@kernel.org>
User-Agent: Notmuch/0.37 (https://notmuchmail.org)
Date: Mon, 17 Apr 2023 10:47:47 +0200
Message-ID: <878reqlwss.fsf@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.3
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain
Subject: [virtio-dev] Participation (was: Re: [virtio-comment] RE: [virtio-dev] RE:
 [PATCH v12 03/10] content: Rename confusing queue_notify_data and vqn
 names)

On Mon, Apr 17 2023, "Michael S. Tsirkin" <mst@redhat.com> wrote:

> I am not saying don't give feedback but I'm saying please help us
> all be more organized, feedback time really should be within a
> day or two, in rare cases up to a week.

Given that there are things like weekends, public holidays, etc. one day
does not look reasonable; while it certainly makes sense to continue if
no feedback is forthcoming for a few days, not accounting for the fact
that this is not the exclusive job for most/any of us is just a fast
track to either burnout or people dropping out of virtio standardization
altogether.

> And I'd like to remind everyone if you are going away you are supposed
> to report a leave of absence.

Well... "Each request shall be made by sending an email to the TC
mailing list at least 7 days before the Leave is to start." is probably
not going to work for many cases. (Also, in any other community I'm
participating in it is expected that you just might not be there or have
time to work on it every week -- I've always seen that leave of absence
thingy as something for a really long vacation or for something like
parental leave, for which the max 45 days is really too short...) Not to
mention that it applies to voting, not to participation on the lists.

> TC's that have meetings just take away voting rights from someone who
> does not attend two meetings in a row.  We do it by ballot so this does
> not apply, but I think we should set some limits in group's bylaws,
> anyway. Ideas on formalizing this? If not we can just have informal
> guidelines.  There's of course a flip side to this. Some patches
> seemingly go through two versions a day. Keeping up becomes a full time
> job. We'd need a guideline for that, too.

What do we actually expect from TC members? "Reply to emails" is not
part of any formal requirement AFAICS (and not all TC members do
participate on the lists on a regular basis anyway). The requirement is
only to vote on the ballots, and there you're completely free to vote
"abstain", so you can always squeeze in voting even if you're not able
to participate otherwise. I think that's fine.

"If I don't get a reply after $NUMBER_OF_WORKING_DAYS, I'll assume I can
proceed as I think fit" is a reasonable assumption to make, e.g. to
request a vote. Not sure if/how to formalize that. Also, how is this
supposed to work if the original author doesn't reply to comments?
Should the proposal be considered abandoned?

I agree that patch reposting is happening much too fast in some
cases. Not sure how to formalize that, either. Can we please just be
more mindful of that? Reviewing time is not free. If I'm trying to do a
timely review of something and constantly see new versions while I'm not
finished yet, I do not feel like my feedback is actually valued.

> I also feel high latency is one of the reasons people are beginning to
> ask to split into subcommitees where they won't have to deal with this
> kind of thing. Let's try to keep the latency low, please.

I think there's multiple things to unpack here.

- The very common strain of limited reviewer time. This seems to be an
  issue nearly everywhere. Encouraging more review helps; but if review
  and ensuing discussing turns into a time sink, it just cannot be
  handled at a reasonable activity level anymore.
- Latency due to missing feedback. Can be solved by just requesting a
  vote if no feedback is forthcoming in a reasonable time frame.
- Latency due to missing reaction to feedback. This means the proposal
  just doesn't make any progress. The onus is on the submitter here.
- Conflicting approaches favoured by different people. This cannot be
  resolved in a formal way; either people need to be convinced that a
  certain approach will work, a middle ground found, or a way worked out
  that the different approaches can co-exist. In any case, this usually
  means long discussions which can be very frustrating, but unless we
  want to bulldoze over some people this is something we'll have to
  live with. [Personally, I think this is the worst contributor to
  frustration, and not something that can be solved by subcommittees.]
- [I'm also not happy with the tone of some emails I've been seeing. I
  won't point to them in order not to stir up things that have already
  calmed down again.]


---------------------------------------------------------------------
To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org

