Return-Path: virtio-dev-return-4009-cohuck=redhat.com@lists.oasis-open.org
Sender: <virtio-dev@lists.oasis-open.org>
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [66.179.20.138])
	by lists.oasis-open.org (Postfix) with ESMTP id CFD2C581810F
	for <virtio-dev@lists.oasis-open.org>; Sun, 29 Apr 2018 19:47:57 -0700 (PDT)
From: "Samudrala, Sridhar" <sridhar.samudrala@intel.com>
References: <1524848820-42258-1-git-send-email-sridhar.samudrala@intel.com>
 <1524848820-42258-3-git-send-email-sridhar.samudrala@intel.com>
 <20180428081542.GJ5632@nanopsycho.orion>
Message-ID: <3d481b29-896d-6d2f-0822-85c3077e8b4f@intel.com>
Date: Sun, 29 Apr 2018 19:47:54 -0700
MIME-Version: 1.0
In-Reply-To: <20180428081542.GJ5632@nanopsycho.orion>
Content-Type: multipart/alternative;
 boundary="------------8D4AB5F7B80B2EED5C9D0607"
Content-Language: en-US
Subject: [virtio-dev] Re: [PATCH net-next v9 2/4] net: Introduce generic failover module
To: Jiri Pirko <jiri@resnulli.us>
Cc: mst@redhat.com, stephen@networkplumber.org, davem@davemloft.net, netdev@vger.kernel.org, virtualization@lists.linux-foundation.org, virtio-dev@lists.oasis-open.org, jesse.brandeburg@intel.com, alexander.h.duyck@intel.com, kubakici@wp.pl, jasowang@redhat.com, loseweigh@gmail.com, aaron.f.brown@intel.com
List-ID: <virtio-dev.lists.oasis-open.org>

--------------8D4AB5F7B80B2EED5C9D0607
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit

On 4/28/2018 1:15 AM, Jiri Pirko wrote:
> Fri, Apr 27, 2018 at 07:06:58PM CEST,sridhar.samudrala@intel.com  wrote:
>> This provides a generic interface for paravirtual drivers to listen
>> for netdev register/unregister/link change events from pci ethernet
>> devices with the same MAC and takeover their datapath. The notifier and
>> event handling code is based on the existing netvsc implementation.
>>
>> It exposes 2 sets of interfaces to the paravirtual drivers.
>> 1. For paravirtual drivers like virtio_net that use 3 netdev model, the
>>    the failover module provides interfaces to create/destroy additional
>>    master netdev and all the slave events are managed internally.
>>         net_failover_create()
>>         net_failover_destroy()
>>    A failover netdev is created that acts a master device and controls 2
>>    slave devices. The original virtio_net netdev is registered as 'standby'
>>    netdev and a passthru/vf device with the same MAC gets registered as
>>    'primary' netdev. Both 'standby' and 'primary' netdevs are associated
>>    with the same 'pci' device.  The user accesses the network interface via
> 'standby' and 'primary' netdevs are not associated with the same 'pci'
> device.
> "Primary" is the VF netdevice and "standby" is virtio_net. Each
> associated with different pci device.

I meant to say that 'standby' and 'failover' netdevs are associated with
the same 'pci' device. will fix it in v10.


>
>>    'failover' netdev. The 'failover' netdev chooses 'primary' netdev as
>>    default for transmits when it is available with link up and running.
>> 2. For existing netvsc driver that uses 2 netdev model, no master netdev
>>    is created. The paravirtual driver registers each instance of netvsc
>>    as a 'failover' netdev  along with a set of ops to manage the slave
>>    events. There is no 'standby' netdev in this model. A passthru/vf device
>>    with the same MAC gets registered as 'primary' netdev.
>>         net_failover_register()
>>         net_failover_unregister()
> [...]


--------------8D4AB5F7B80B2EED5C9D0607
Content-Type: text/html; charset=utf-8
Content-Transfer-Encoding: 7bit

<html>
  <head>
    <meta http-equiv="Content-Type" content="text/html; charset=utf-8">
  </head>
  <body text="#000000" bgcolor="#FFFFFF">
    On 4/28/2018 1:15 AM, Jiri Pirko wrote:<br>
    <blockquote type="cite"
      cite="mid:20180428081542.GJ5632@nanopsycho.orion">
      <pre wrap="">Fri, Apr 27, 2018 at 07:06:58PM CEST, <a class="moz-txt-link-abbreviated" href="mailto:sridhar.samudrala@intel.com">sridhar.samudrala@intel.com</a> wrote:
</pre>
      <blockquote type="cite">
        <pre wrap="">This provides a generic interface for paravirtual drivers to listen
for netdev register/unregister/link change events from pci ethernet
devices with the same MAC and takeover their datapath. The notifier and
event handling code is based on the existing netvsc implementation.

It exposes 2 sets of interfaces to the paravirtual drivers.
1. For paravirtual drivers like virtio_net that use 3 netdev model, the
  the failover module provides interfaces to create/destroy additional
  master netdev and all the slave events are managed internally.
       net_failover_create()
       net_failover_destroy()
  A failover netdev is created that acts a master device and controls 2
  slave devices. The original virtio_net netdev is registered as 'standby'
  netdev and a passthru/vf device with the same MAC gets registered as
  'primary' netdev. Both 'standby' and 'primary' netdevs are associated
  with the same 'pci' device.  The user accesses the network interface via
</pre>
      </blockquote>
      <pre wrap="">'standby' and 'primary' netdevs are not associated with the same 'pci'
device.
"Primary" is the VF netdevice and "standby" is virtio_net. Each
associated with different pci device.</pre>
    </blockquote>
    <br>
    <pre>I meant to say that 'standby' and 'failover' netdevs are associated with
the same 'pci' device. will fix it in v10.</pre>
    <br>
    <blockquote type="cite"
      cite="mid:20180428081542.GJ5632@nanopsycho.orion">
      <pre wrap="">

</pre>
      <blockquote type="cite">
        <pre wrap="">  'failover' netdev. The 'failover' netdev chooses 'primary' netdev as
  default for transmits when it is available with link up and running.
2. For existing netvsc driver that uses 2 netdev model, no master netdev
  is created. The paravirtual driver registers each instance of netvsc
  as a 'failover' netdev  along with a set of ops to manage the slave
  events. There is no 'standby' netdev in this model. A passthru/vf device
  with the same MAC gets registered as 'primary' netdev.
       net_failover_register()
       net_failover_unregister()
</pre>
      </blockquote>
      <pre wrap="">[...]
</pre>
    </blockquote>
    <br>
  </body>
</html>

--------------8D4AB5F7B80B2EED5C9D0607--
