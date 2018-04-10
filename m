Return-Path: virtio-dev-return-3799-cohuck=redhat.com@lists.oasis-open.org
Sender: <virtio-dev@lists.oasis-open.org>
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [66.179.20.138])
	by lists.oasis-open.org (Postfix) with ESMTP id AEA0B5818038
	for <virtio-dev@lists.oasis-open.org>; Tue, 10 Apr 2018 15:56:35 -0700 (PDT)
References: <1523386790-12396-1-git-send-email-sridhar.samudrala@intel.com>
 <1523386790-12396-5-git-send-email-sridhar.samudrala@intel.com>
 <20180410142608.50f15b45@xeon-e3>
From: "Samudrala, Sridhar" <sridhar.samudrala@intel.com>
Message-ID: <857f55f1-9d55-1c44-16e0-683ba2e3f2ec@intel.com>
Date: Tue, 10 Apr 2018 15:56:23 -0700
MIME-Version: 1.0
In-Reply-To: <20180410142608.50f15b45@xeon-e3>
Content-Type: text/plain; charset="utf-8"; format="flowed"
Content-Transfer-Encoding: 8bit
Content-Language: en-US
Subject: [virtio-dev] Re: [RFC PATCH net-next v6 4/4] netvsc: refactor notifier/event
 handling code to use the bypass framework
To: Stephen Hemminger <stephen@networkplumber.org>
Cc: mst@redhat.com, davem@davemloft.net, netdev@vger.kernel.org, virtualization@lists.linux-foundation.org, virtio-dev@lists.oasis-open.org, jesse.brandeburg@intel.com, alexander.h.duyck@intel.com, kubakici@wp.pl, jasowang@redhat.com, loseweigh@gmail.com, jiri@resnulli.us
List-ID: <virtio-dev.lists.oasis-open.org>

On 4/10/2018 2:26 PM, Stephen Hemminger wrote:
> On Tue, 10 Apr 2018 11:59:50 -0700
> Sridhar Samudrala <sridhar.samudrala@intel.com> wrote:
>
>> Use the registration/notification framework supported by the generic
>> bypass infrastructure.
>>
>> Signed-off-by: Sridhar Samudrala <sridhar.samudrala@intel.com>
>> ---
> Thanks for doing this.  Your current version has couple show stopper
> issues.
>
> First, the slave device is instantly taking over the slave.
> This doesn't allow udev/systemd to do its device rename of the slave
> device. Netvsc uses a delayed work to workaround this.

OK. I guess you are referring to the dev_set_mtu() and dev_open() calls that are
made in bypass_slave_register() and you want to defer them to be done after
a delay.  I could avoid these calls in case of netvsc based on bypass_ops.


>
> Secondly, the select queue needs to call queue selection in VF.
> The bonding/teaming logic doesn't work well for UDP flows.
> Commit b3bf5666a510 ("hv_netvsc: defer queue selection to VF")
> fixed this performance problem.

netvsc should not be using bypass_select_queue() as  that ndo op gets used
only with 3-netdev model.
Anyway, will look into updating bypass_select_queue() based on your fix.

>
> Lastly, more indirection is bad in current climate.
>
> I am not completely adverse to this but it needs to be fast, simple
> and completely transparent.

Not sure we can avoid this indirection if we want to commonize the code,  but use
different models for virtio-net and netvsc.

On the other hand, these patches avoid calls to get_netvsc_bymac() and
get_netvsc_by_ref() that go through all the devices for all the netdev events.
netvsc lookups should be much faster.

Thanks
Sridhar


---------------------------------------------------------------------
To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org

