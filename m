Return-Path: virtio-dev-return-6711-cohuck=redhat.com@lists.oasis-open.org
Sender: <virtio-dev@lists.oasis-open.org>
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id 5E95D985D19
	for <virtio-dev@lists.oasis-open.org>; Tue, 11 Feb 2020 03:24:50 +0000 (UTC)
References: <1579614873-21907-1-git-send-email-jing2.liu@linux.intel.com>
 <1579614873-21907-6-git-send-email-jing2.liu@linux.intel.com>
 <20200129051247-mutt-send-email-mst@kernel.org>
From: "Liu, Jing2" <jing2.liu@linux.intel.com>
Message-ID: <4f2e205a-3066-f917-fdc6-e110f1d3bf62@linux.intel.com>
Date: Tue, 11 Feb 2020 11:24:41 +0800
MIME-Version: 1.0
In-Reply-To: <20200129051247-mutt-send-email-mst@kernel.org>
Content-Language: en-US
Subject: Re: [virtio-dev] [PATCH v2 5/5] virtio-mmio: MSI vector and event
 mapping
Content-Type: multipart/alternative;
 boundary="------------E0DF50F0F1B6F5FC0B1C724C"
To: "Michael S. Tsirkin" <mst@redhat.com>
Cc: virtio-dev@lists.oasis-open.org, linux-kernel@vger.kernel.org, kvm@vger.kernel.org, qemu-devel@nongnu.org, Chao Peng <chao.p.peng@linux.intel.com>, Liu Jiang <gerry@linux.alibaba.com>, Zha Bin <zhabin@linux.alibaba.com>
List-ID: <virtio-dev.lists.oasis-open.org>

--------------E0DF50F0F1B6F5FC0B1C724C
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable


On 1/29/2020 6:14 PM, Michael S. Tsirkin wrote:
> On Tue, Jan 21, 2020 at 09:54:33PM +0800, Jing Liu wrote:
>> Bit 1 msi_sharing reported in the MsiState register indicates the mappin=
g mode
>> device uses.
>>
>> Bit 1 is 0 - device uses MSI non-sharing mode. This indicates vector per=
 event and
>> fixed static vectors and events relationship. This fits for devices with=
 a high interrupt
>> rate and best performance;
>> Bit 1 is 1 - device uses MSI sharing mode. This indicates vectors and ev=
ents
>> dynamic mapping and fits for devices not requiring a high interrupt rate=
.

Thanks for reviewing! Sorry for the late reply.

For msi sharing/non-sharing mode, we are trying to define a rule that,

simply using 1 bit to indicate what device wants and what driver should=20
do. Let me try to explain details.

If it's sharing mode (bit=3D1), it means device doesn't want vector per=20
queue or a high interrupt rate.

Driver should meet such request.

So define that, device should support at least 2 msi vectors and driver=20
should use

VIRTIO_MMIO_MSI_CMD_MAP_CONFIG/VIRTIO_MMIO_MSI_CMD_MAP_QUEUE commands

to map the configuration change/selected queue events.

In implementation, driver will detect the bit=3D1, turn to !per_vq_vector=
=20
and map 1 vector for config

and 1 for all queues to meet the request. (Maybe we need restrict this=20
in spec too.)

> It seems that sharing mode is a superset of non-sharing mode.

I think sharing mode is not a superset, because driver should not map=20
1:1 which will go against

the request from device that it doesn't want 1:1 (non-sharing mode).

In other words, device chooses the way it wants, a high interrupt rate=20
with 1:1 or not.

> Isn't that right? E.g. with sharing mode drivers
> can still avoid sharing if they like.
Drivers should not avoid msi sharing if that bit is 1.
> Maybe it should just be a hint to drivers whether to share
> interrupts,
The sharing mode bit is the hint to indicate whether to share interrupts. :=
)
> instead of a completely different layout?

Except the bit, no other different register layout is there for such=20
feature.

Thanks!

Jing

>> diff --git a/msi-state.c b/msi-state.c
>> index b1fa0c1..d470be4 100644
>> --- a/msi-state.c
>> +++ b/msi-state.c
>> @@ -1,4 +1,5 @@
>>   le32 {
>>       msi_enabled : 1;
>> -    reserved : 31;
>> +    msi_sharing: 1;
>> +    reserved : 30;
>>   };
>> --=20
>> 2.7.4
>>
>>
>> ---------------------------------------------------------------------
>> To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
>> For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org

--------------E0DF50F0F1B6F5FC0B1C724C
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<html>
  <head>
    <meta http-equiv=3D"Content-Type" content=3D"text/html; charset=3DUTF-8=
">
  </head>
  <body>
    <p><br>
    </p>
    <div class=3D"moz-cite-prefix">On 1/29/2020 6:14 PM, Michael S.
      Tsirkin wrote:<br>
    </div>
    <blockquote type=3D"cite"
      cite=3D"mid:20200129051247-mutt-send-email-mst@kernel.org">
      <pre class=3D"moz-quote-pre" wrap=3D"">On Tue, Jan 21, 2020 at 09:54:=
33PM +0800, Jing Liu wrote:
</pre>
      <blockquote type=3D"cite">
        <pre class=3D"moz-quote-pre" wrap=3D"">Bit 1 msi_sharing reported i=
n the MsiState register indicates the mapping mode
device uses.

Bit 1 is 0 - device uses MSI non-sharing mode. This indicates vector per ev=
ent and
fixed static vectors and events relationship. This fits for devices with a =
high interrupt
rate and best performance;
Bit 1 is 1 - device uses MSI sharing mode. This indicates vectors and event=
s
dynamic mapping and fits for devices not requiring a high interrupt rate.
</pre>
      </blockquote>
    </blockquote>
    <p>Thanks for reviewing! Sorry for the late reply. <br>
    </p>
    <p>For msi sharing/non-sharing mode, we are trying to define a rule
      that, <br>
    </p>
    <p>simply using 1 bit to indicate what device wants and what driver
      should do. Let me try to explain details.<br>
    </p>
    <p>If it's sharing mode (bit=3D1), it means device doesn't want vector
      per queue or a high interrupt rate.</p>
    <p>Driver should meet such request.</p>
    <p>So define that, device should support at least 2 msi vectors and
      driver should use <br>
    </p>
    <p><span class=3D"fontstyle0">VIRTIO_MMIO_MSI_CMD_MAP_CONFIG/VIRTIO_MMI=
O_MSI_CMD_MAP_QUEUE
        commands</span></p>
    <p><span class=3D"fontstyle0"> to map the configuration
        change/selected queue events</span>.<br style=3D" font-style:
        normal; font-variant: normal; font-weight: normal;
        letter-spacing: normal; line-height: normal; orphans: 2;
        text-align: -webkit-auto; text-indent: 0px; text-transform:
        none; white-space: normal; widows: 2; word-spacing: 0px;
        -webkit-text-size-adjust: auto; -webkit-text-stroke-width: 0px;
        ">
    </p>
    <p>In implementation, driver will detect the bit=3D1, turn to
      !per_vq_vector and map 1 vector for config</p>
    <p> and 1 for all queues to meet the request. (Maybe we need
      restrict this in spec too.)<br>
    </p>
    <blockquote type=3D"cite"
      cite=3D"mid:20200129051247-mutt-send-email-mst@kernel.org">
      <pre class=3D"moz-quote-pre" wrap=3D"">
It seems that sharing mode is a superset of non-sharing mode.</pre>
    </blockquote>
    <p>I think sharing mode is not a superset, because driver should not
      map 1:1 which will go against</p>
    <p>the request from device that it doesn't want 1:1 (non-sharing
      mode).</p>
    <p>In other words, device chooses the way it wants, a high interrupt
      rate with 1:1 or not.<br>
    </p>
    <blockquote type=3D"cite"
      cite=3D"mid:20200129051247-mutt-send-email-mst@kernel.org">
      <pre class=3D"moz-quote-pre" wrap=3D"">
Isn't that right? E.g. with sharing mode drivers
can still avoid sharing if they like.</pre>
    </blockquote>
    Drivers should not avoid msi sharing if that bit is 1.<br>
    <blockquote type=3D"cite"
      cite=3D"mid:20200129051247-mutt-send-email-mst@kernel.org">
      <pre class=3D"moz-quote-pre" wrap=3D"">
Maybe it should just be a hint to drivers whether to share
interrupts, </pre>
    </blockquote>
    The sharing mode bit is the hint to indicate whether to share
    interrupts. :)<br>
    <blockquote type=3D"cite"
      cite=3D"mid:20200129051247-mutt-send-email-mst@kernel.org">
      <pre class=3D"moz-quote-pre" wrap=3D"">instead of a completely differ=
ent layout?</pre>
    </blockquote>
    <p>Except the bit, no other different register layout is there for
      such feature.</p>
    <p>Thanks!<br>
    </p>
    <p>Jing<br>
    </p>
    <blockquote type=3D"cite"
      cite=3D"mid:20200129051247-mutt-send-email-mst@kernel.org">
      <blockquote type=3D"cite">
        <pre class=3D"moz-quote-pre" wrap=3D"">diff --git a/msi-state.c b/m=
si-state.c
index b1fa0c1..d470be4 100644
--- a/msi-state.c
+++ b/msi-state.c
@@ -1,4 +1,5 @@
 le32 {
     msi_enabled : 1;
-    reserved : 31;
+    msi_sharing: 1;
+    reserved : 30;
 };
--=20
2.7.4


---------------------------------------------------------------------
To unsubscribe, e-mail: <a class=3D"moz-txt-link-abbreviated" href=3D"mailt=
o:virtio-dev-unsubscribe@lists.oasis-open.org">virtio-dev-unsubscribe@lists=
.oasis-open.org</a>
For additional commands, e-mail: <a class=3D"moz-txt-link-abbreviated" href=
=3D"mailto:virtio-dev-help@lists.oasis-open.org">virtio-dev-help@lists.oasi=
s-open.org</a>
</pre>
      </blockquote>
      <pre class=3D"moz-quote-pre" wrap=3D"">
</pre>
    </blockquote>
  </body>
</html>

--------------E0DF50F0F1B6F5FC0B1C724C--

