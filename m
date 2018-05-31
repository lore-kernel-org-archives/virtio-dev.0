Return-Path: virtio-dev-return-4215-cohuck=redhat.com@lists.oasis-open.org
Sender: <virtio-dev@lists.oasis-open.org>
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [66.179.20.138])
	by lists.oasis-open.org (Postfix) with ESMTP id 64E451CB8078
	for <virtio-dev@lists.oasis-open.org>; Wed, 30 May 2018 20:03:23 -0700 (PDT)
References: <1527180917-39737-1-git-send-email-sridhar.samudrala@intel.com>
 <1527180917-39737-3-git-send-email-sridhar.samudrala@intel.com>
 <20180530220635.206ee6d7@shemminger-XPS-13-9360>
From: "Samudrala, Sridhar" <sridhar.samudrala@intel.com>
Message-ID: <274f0b84-07f1-5cd5-e256-ce4b71358c14@intel.com>
Date: Wed, 30 May 2018 20:03:11 -0700
MIME-Version: 1.0
In-Reply-To: <20180530220635.206ee6d7@shemminger-XPS-13-9360>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Subject: [virtio-dev] Re: [PATCH net-next v12 2/5] netvsc: refactor notifier/event handling
 code to use the failover framework
To: Stephen Hemminger <stephen@networkplumber.org>
Cc: mst@redhat.com, davem@davemloft.net, netdev@vger.kernel.org, virtualization@lists.linux-foundation.org, virtio-dev@lists.oasis-open.org, jesse.brandeburg@intel.com, alexander.h.duyck@intel.com, kubakici@wp.pl, jasowang@redhat.com, loseweigh@gmail.com, jiri@resnulli.us, aaron.f.brown@intel.com, anjali.singhai@intel.com
List-ID: <virtio-dev.lists.oasis-open.org>



On 5/30/2018 7:06 PM, Stephen Hemminger wrote:
> On Thu, 24 May 2018 09:55:14 -0700
> Sridhar Samudrala <sridhar.samudrala@intel.com> wrote:
>
>> Use the registration/notification framework supported by the generic
>> failover infrastructure.
>>
>> Signed-off-by: Sridhar Samudrala <sridhar.samudrala@intel.com>
> Why was this merged? It was never signed off by any of the netvsc maintainers,
> and there were still issues unresolved.
>
> There are also namespaces issues I am fixing and this breaks them.
> Will start my patch set with a revert for this. Sorry

I would appreciate if you can make the fixes on top of this patch series. I tried hard
to make sure that netvsc functionality and behavior doesn't change.

It is possible that there could be some bugs introduced, but they can be fixed.
Looks like Wei already found a bug and submitted a fix for that.


---------------------------------------------------------------------
To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org

