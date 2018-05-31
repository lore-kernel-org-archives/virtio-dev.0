Return-Path: virtio-dev-return-4221-cohuck=redhat.com@lists.oasis-open.org
Sender: <virtio-dev@lists.oasis-open.org>
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [66.179.20.138])
	by lists.oasis-open.org (Postfix) with ESMTP id B1EB75818CC0
	for <virtio-dev@lists.oasis-open.org>; Thu, 31 May 2018 13:42:07 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <20180531212356-mutt-send-email-mst@kernel.org>
References: <1527180917-39737-1-git-send-email-sridhar.samudrala@intel.com>
 <1527180917-39737-3-git-send-email-sridhar.samudrala@intel.com>
 <20180530220635.206ee6d7@shemminger-XPS-13-9360> <20180531212356-mutt-send-email-mst@kernel.org>
From: Siwei Liu <loseweigh@gmail.com>
Date: Thu, 31 May 2018 13:41:56 -0700
Message-ID: <CADGSJ23N=8=of_4fKF+r31E-ywewLM7B1JhL6X0qZFP-ORdLQA@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: [virtio-dev] Re: [PATCH net-next v12 2/5] netvsc: refactor notifier/event handling
 code to use the failover framework
To: "Michael S. Tsirkin" <mst@redhat.com>, venu.busireddy@oracle.com
Cc: Stephen Hemminger <stephen@networkplumber.org>, Sridhar Samudrala <sridhar.samudrala@intel.com>, David Miller <davem@davemloft.net>, Netdev <netdev@vger.kernel.org>, virtualization@lists.linux-foundation.org, virtio-dev@lists.oasis-open.org, "Brandeburg, Jesse" <jesse.brandeburg@intel.com>, Alexander Duyck <alexander.h.duyck@intel.com>, Jakub Kicinski <kubakici@wp.pl>, Jason Wang <jasowang@redhat.com>, Jiri Pirko <jiri@resnulli.us>, aaron.f.brown@intel.com, anjali.singhai@intel.com
List-ID: <virtio-dev.lists.oasis-open.org>

On Thu, May 31, 2018 at 11:35 AM, Michael S. Tsirkin <mst@redhat.com> wrote:
> On Wed, May 30, 2018 at 10:06:35PM -0400, Stephen Hemminger wrote:
>> On Thu, 24 May 2018 09:55:14 -0700
>> Sridhar Samudrala <sridhar.samudrala@intel.com> wrote:
>>
>> > Use the registration/notification framework supported by the generic
>> > failover infrastructure.
>> >
>> > Signed-off-by: Sridhar Samudrala <sridhar.samudrala@intel.com>
>>
>> Why was this merged? It was never signed off by any of the netvsc maintainers,
>> and there were still issues unresolved.
>>
>> There are also namespaces issues I am fixing and this breaks them.
>> Will start my patch set with a revert for this. Sorry
>
> As long as you finish the patch set with re-integrating with failover,
> that's fine IMHO.
>
> I suspect it's easier to add the code to failover though - namespace
> things likely affect virtio as well. Lookup by ID would be an optional
> feature for virtio, but probably a useful one - I won't ask you
I would think for production uses this is a required feature and
should be enabled by default.

Venu (cc'ed) is working on the group ID stuff currently for pairing
virtio and passthrough devices. Would appreciate feedback on the group
ID proposal on virtio-dev.

-Siwei

> to add it to virtio but it could be a mode in failover
> that virtio will activate down the road. And reducing the number of
> times we look cards up based on ID can only be a good thing.
>
> --
> MST

---------------------------------------------------------------------
To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org

