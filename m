Return-Path: <virtio-dev-return-9011-cohuck=redhat.com@lists.oasis-open.org>
Sender: <virtio-dev@lists.oasis-open.org>
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id 428DD986254
	for <virtio-dev@lists.oasis-open.org>; Mon, 10 Jan 2022 11:13:00 +0000 (UTC)
From: Cornelia Huck <cohuck@redhat.com>
In-Reply-To: <CACGkMEtdOpgM6ziP-60JAfjOPk6isL5Nm4ywpzHjyiLACnOgEw@mail.gmail.com>
References: <CACGkMEv96GWNCjvawwKxKY2vFSh-fH6U=aca8xMGswVDiCGdZQ@mail.gmail.com>
 <1641524442.5169451-1-xuanzhuo@linux.alibaba.com>
 <CACGkMEtdOpgM6ziP-60JAfjOPk6isL5Nm4ywpzHjyiLACnOgEw@mail.gmail.com>
Date: Mon, 10 Jan 2022 12:12:52 +0100
Message-ID: <878rvnx2rv.fsf@redhat.com>
MIME-Version: 1.0
Subject: Re: [virtio-dev] Re: [PATCH v7] virtio-net: support device stats
Content-Type: text/plain
To: Jason Wang <jasowang@redhat.com>, Xuan Zhuo <xuanzhuo@linux.alibaba.com>
Cc: Virtio-Dev <virtio-dev@lists.oasis-open.org>
List-ID: <virtio-dev.lists.oasis-open.org>

On Fri, Jan 07 2022, Jason Wang <jasowang@redhat.com> wrote:

> On Fri, Jan 7, 2022 at 11:03 AM Xuan Zhuo <xuanzhuo@linux.alibaba.com> wrote:
>>
>> On Thu, 6 Jan 2022 12:00:14 +0800, Jason Wang <jasowang@redhat.com> wrote:
>> > On Wed, Jan 5, 2022 at 10:49 AM Xuan Zhuo <xuanzhuo@linux.alibaba.com> wrote:
>> > >
>> > > This patch allows the driver to obtain some statistics from the device.
>> > >
>> > > In the back-end implementation, we can count a lot of such information,
>> > > which can be used for debugging and judging the running status of the
>> > > back-end. We hope to directly display it to the user through ethtool.
>> > >
>> > > Signed-off-by: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
>> >
>> > Reviewed-by: Jason Wang <jasowang@redhat.com>
>>
>> hi,
>>
>>     When do you think we can start voting.
>
> I think we need to wait for 1-2 weeks to make sure no further comments
> then we may start the voting.

Not strictly needed; I assume that this patch has already seen good
review from the networking side, I'll take a look at it as well.

>
>> Can this patch enter virtio spec v1.2?
>
> I'm not sure. Adding Cornelia for answering this question.

We need to start voting this week for this to make 1.2 (but no worries,
there will be more releases after that, and it is usually sufficient for
a change to make it into the git repository before implementations can
proceed.)

I did not find a github issue for this, so please follow the process
outlined in https://github.com/oasis-tcs/virtio-spec#use-of-github-issues
to request inclusion.


---------------------------------------------------------------------
To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org

