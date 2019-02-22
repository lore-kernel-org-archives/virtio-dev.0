Return-Path: virtio-dev-return-5496-cohuck=redhat.com@lists.oasis-open.org
Sender: <virtio-dev@lists.oasis-open.org>
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis.ws5.connectedcommunity.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id 8B9CB985D1D
	for <virtio-dev@lists.oasis-open.org>; Fri, 22 Feb 2019 07:00:15 +0000 (UTC)
References: <1523386790-12396-1-git-send-email-sridhar.samudrala@intel.com>
 <1523386790-12396-5-git-send-email-sridhar.samudrala@intel.com>
 <20180410142608.50f15b45@xeon-e3> <20180411075334.GK2028@nanopsycho>
 <CADGSJ214RJV_zWVBGv0Ydo=CJj6WESTYAH=PpaYLFHdtWVrm3g@mail.gmail.com>
 <20190221203808-mutt-send-email-mst@kernel.org>
 <581e4399-3969-aecd-e923-03bbc0880733@oracle.com>
From: "Samudrala, Sridhar" <sridhar.samudrala@intel.com>
Message-ID: <91d4cbb1-be7a-b53c-6b2a-99bef07e7c53@intel.com>
Date: Thu, 21 Feb 2019 23:00:04 -0800
MIME-Version: 1.0
In-Reply-To: <581e4399-3969-aecd-e923-03bbc0880733@oracle.com>
Content-Type: multipart/alternative;
 boundary="------------3DC89C74F2F5950B3AA5C02B"
Content-Language: en-US
Subject: Re: [virtio-dev] Re: net_failover slave udev renaming (was Re: [RFC
 PATCH net-next v6 4/4] netvsc: refactor notifier/event handling code to use
 the bypass framework)
To: si-wei liu <si-wei.liu@oracle.com>, "Michael S. Tsirkin" <mst@redhat.com>, Siwei Liu <loseweigh@gmail.com>
Cc: Jiri Pirko <jiri@resnulli.us>, Stephen Hemminger <stephen@networkplumber.org>, David Miller <davem@davemloft.net>, Netdev <netdev@vger.kernel.org>, virtualization@lists.linux-foundation.org, virtio-dev <virtio-dev@lists.oasis-open.org>, "Brandeburg, Jesse" <jesse.brandeburg@intel.com>, Alexander Duyck <alexander.h.duyck@intel.com>, Jakub Kicinski <kubakici@wp.pl>, Jason Wang <jasowang@redhat.com>, liran.alon@oracle.com
List-ID: <virtio-dev.lists.oasis-open.org>

--------------3DC89C74F2F5950B3AA5C02B
Content-Type: text/plain; charset="windows-1252"; format="flowed"
Content-Transfer-Encoding: quoted-printable


On 2/21/2019 7:33 PM, si-wei liu wrote:
>
>
> On 2/21/2019 5:39 PM, Michael S. Tsirkin wrote:
>> On Thu, Feb 21, 2019 at 05:14:44PM -0800, Siwei Liu wrote:
>>> Sorry for replying to this ancient thread. There was some remaining
>>> issue that I don't think the initial net_failover patch got addressed
>>> cleanly, see:
>>>
>>> https://bugs.launchpad.net/ubuntu/+source/linux/+bug/1815268
>>>
>>> The renaming of 'eth0' to 'ens4' fails because the udev userspace was
>>> not specifically writtten for such kernel automatic enslavement.
>>> Specifically, if it is a bond or team, the slave would typically get
>>> renamed *before* virtual device gets created, that's what udev can
>>> control (without getting netdev opened early by the other part of
>>> kernel) and other userspace components for e.g. initramfs,
>>> init-scripts can coordinate well in between. The in-kernel
>>> auto-enslavement of net_failover breaks this userspace convention,
>>> which don't provides a solution if user care about consistent naming
>>> on the slave netdevs specifically.
>>>
>>> Previously this issue had been specifically called out when IFF_HIDDEN
>>> and the 1-netdev was proposed, but no one gives out a solution to this
>>> problem ever since. Please share your mind how to proceed and solve
>>> this userspace issue if netdev does not welcome a 1-netdev model.
>> Above says:
>>
>> =A0=A0=A0=A0there's no motivation in the systemd/udevd community at
>> =A0=A0=A0=A0this point to refactor the rename logic and make it work wel=
l with
>> =A0=A0=A0=A03-netdev.
>>
>> What would the fix be? Skip slave devices?
>>
> There's nothing user can get if just skipping slave devices - the name=20
> is still unchanged and unpredictable e.g. eth0, or eth1 the next=20
> reboot, while the rest may conform to the naming scheme (ens3 and=20
> such). There's no way one can fix this in userspace alone - when the=20
> failover is created the enslaved netdev was opened by the kernel=20
> earlier than the userspace is made aware of, and there's no=20
> negotiation protocol for kernel to know when userspace has done=20
> initial renaming of the interface. I would expect netdev list should=20
> at least provide the direction in general for how this can be solved...
>
Is there an issue if slave device names are not predictable? The user/admin=
 scripts are expected
to only work with the master failover device.
Moreover, you were suggesting hiding the lower slave devices anyway. There =
was some discussion
about moving them to a hidden network namespace so that they are not visibl=
e from the default namespace.
I looked into this sometime back, but did not find the right kernel api to =
create a network namespace within
kernel. If so, we could use this mechanism to simulate a 1-netdev model.


> -Siwei
>
>

--------------3DC89C74F2F5950B3AA5C02B
Content-Type: text/html; charset="windows-1252"
Content-Transfer-Encoding: quoted-printable

<html>
  <head>
    <meta http-equiv=3D"Content-Type" content=3D"text/html;
      charset=3Dwindows-1252">
  </head>
  <body text=3D"#000000" bgcolor=3D"#FFFFFF">
    <p><br>
    </p>
    <div class=3D"moz-cite-prefix">On 2/21/2019 7:33 PM, si-wei liu wrote:<=
br>
    </div>
    <blockquote type=3D"cite"
      cite=3D"mid:581e4399-3969-aecd-e923-03bbc0880733@oracle.com">
      <br>
      <br>
      On 2/21/2019 5:39 PM, Michael S. Tsirkin wrote:
      <br>
      <blockquote type=3D"cite">On Thu, Feb 21, 2019 at 05:14:44PM -0800,
        Siwei Liu wrote:
        <br>
        <blockquote type=3D"cite">Sorry for replying to this ancient
          thread. There was some remaining
          <br>
          issue that I don't think the initial net_failover patch got
          addressed
          <br>
          cleanly, see:
          <br>
          <br>
          <a class=3D"moz-txt-link-freetext" href=3D"https://bugs.launchpad=
.net/ubuntu/+source/linux/+bug/1815268">https://bugs.launchpad.net/ubuntu/+=
source/linux/+bug/1815268</a>
          <br>
          <br>
          The renaming of 'eth0' to 'ens4' fails because the udev
          userspace was
          <br>
          not specifically writtten for such kernel automatic
          enslavement.
          <br>
          Specifically, if it is a bond or team, the slave would
          typically get
          <br>
          renamed *before* virtual device gets created, that's what udev
          can
          <br>
          control (without getting netdev opened early by the other part
          of
          <br>
          kernel) and other userspace components for e.g. initramfs,
          <br>
          init-scripts can coordinate well in between. The in-kernel
          <br>
          auto-enslavement of net_failover breaks this userspace
          convention,
          <br>
          which don't provides a solution if user care about consistent
          naming
          <br>
          on the slave netdevs specifically.
          <br>
          <br>
          Previously this issue had been specifically called out when
          IFF_HIDDEN
          <br>
          and the 1-netdev was proposed, but no one gives out a solution
          to this
          <br>
          problem ever since. Please share your mind how to proceed and
          solve
          <br>
          this userspace issue if netdev does not welcome a 1-netdev
          model.
          <br>
        </blockquote>
        Above says:
        <br>
        <br>
        =A0=A0=A0=A0there's no motivation in the systemd/udevd community at
        <br>
        =A0=A0=A0=A0this point to refactor the rename logic and make it work
        well with
        <br>
        =A0=A0=A0=A03-netdev.
        <br>
        <br>
        What would the fix be? Skip slave devices?
        <br>
        <br>
      </blockquote>
      There's nothing user can get if just skipping slave devices - the
      name is still unchanged and unpredictable e.g. eth0, or eth1 the
      next reboot, while the rest may conform to the naming scheme (ens3
      and such). There's no way one can fix this in userspace alone -
      when the failover is created the enslaved netdev was opened by the
      kernel earlier than the userspace is made aware of, and there's no
      negotiation protocol for kernel to know when userspace has done
      initial renaming of the interface. I would expect netdev list
      should at least provide the direction in general for how this can
      be solved...
      <br>
      <br>
    </blockquote>
    <pre>Is there an issue if slave device names are not predictable? The u=
ser/admin scripts are expected
to only work with the master failover device.
Moreover, you were suggesting hiding the lower slave devices anyway. There =
was some discussion
about moving them to a hidden network namespace so that they are not visibl=
e from the default namespace.
I looked into this sometime back, but did not find the right kernel api to =
create a network namespace within
kernel. If so, we could use this mechanism to simulate a 1-netdev model.
</pre>
    <p><br>
    </p>
    <blockquote type=3D"cite"
      cite=3D"mid:581e4399-3969-aecd-e923-03bbc0880733@oracle.com">-Siwei
      <br>
      <br>
      <br>
    </blockquote>
  </body>
</html>

--------------3DC89C74F2F5950B3AA5C02B--
