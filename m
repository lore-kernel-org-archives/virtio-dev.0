Return-Path: <virtio-dev-return-13559-virtio-dev=archiver.kernel.org@lists.oasis-open.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from ws5-mx01.kavi.com (ws5-mx01.kavi.com [34.193.7.191])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 296D5C0015E
	for <virtio-dev@archiver.kernel.org>; Wed, 16 Aug 2023 02:20:50 +0000 (UTC)
Received: from lists.oasis-open.org (oasis.ws5.connectedcommunity.org [10.110.1.242])
	by ws5-mx01.kavi.com (Postfix) with ESMTP id 91A24C624E
	for <virtio-dev@archiver.kernel.org>; Wed, 16 Aug 2023 02:20:49 +0000 (UTC)
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id 8AD6998642C
	for <virtio-dev@archiver.kernel.org>; Wed, 16 Aug 2023 02:20:49 +0000 (UTC)
Received: from host09.ws5.connectedcommunity.org (host09.ws5.connectedcommunity.org [10.110.1.97])
	by lists.oasis-open.org (Postfix) with QMQP
	id 7E21D9863F0; Wed, 16 Aug 2023 02:20:49 +0000 (UTC)
Mailing-List: contact virtio-dev-help@lists.oasis-open.org; run by ezmlm
List-ID: <virtio-dev.lists.oasis-open.org>
Sender: <virtio-dev@lists.oasis-open.org>
Precedence: bulk
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id 6CFC69863D1;
	Wed, 16 Aug 2023 02:20:46 +0000 (UTC)
X-Virus-Scanned: amavisd-new at kavi.com
X-IronPort-AV: E=McAfee;i="6600,9927,10803"; a="458774975"
X-IronPort-AV: E=Sophos;i="6.01,175,1684825200"; 
   d="scan'208,217";a="458774975"
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10803"; a="683872473"
X-IronPort-AV: E=Sophos;i="6.01,175,1684825200"; 
   d="scan'208,217";a="683872473"
Content-Type: multipart/alternative;
 boundary="------------USCDa0JnZ7N3s1imMawTHyAg"
Message-ID: <02ce48ed-6804-933c-9cf5-3e4123d12530@intel.com>
Date: Wed, 16 Aug 2023 10:20:39 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Firefox/102.0 Thunderbird/102.14.0
Content-Language: en-US
To: Jason Wang <jasowang@redhat.com>
Cc: mst@redhat.com, eperezma@redhat.com, cohuck@redhat.com,
 virtio-comment@lists.oasis-open.org, virtio-dev@lists.oasis-open.org
References: <20230814192904.30062-1-lingshan.zhu@intel.com>
 <20230814192904.30062-2-lingshan.zhu@intel.com>
 <CACGkMEvmYqKTk1Hveo96oKYw4hbEDJD2x5Ye3_nkeBTH0rcMMw@mail.gmail.com>
 <CACGkMEt4mYmf+6+WC=WEZqiJgO2tNo96Ekr5bbyN6akxpjwFqw@mail.gmail.com>
 <47cc93ea-47e9-6390-4752-02f10f2bdc6e@intel.com>
 <CACGkMEvuJ7iBL6NWesi8UO3Vw5216DobkL2bb525Hhh34x3h0w@mail.gmail.com>
From: "Zhu, Lingshan" <lingshan.zhu@intel.com>
In-Reply-To: <CACGkMEvuJ7iBL6NWesi8UO3Vw5216DobkL2bb525Hhh34x3h0w@mail.gmail.com>
Subject: [virtio-dev] Re: [virtio-comment] Re: [RFC PATCH 1/5] virtio: introduce SUSPEND
 bit in device status

--------------USCDa0JnZ7N3s1imMawTHyAg
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit



On 8/16/2023 10:05 AM, Jason Wang wrote:
> On Tue, Aug 15, 2023 at 6:50 PM Zhu, Lingshan<lingshan.zhu@intel.com>  wrote:
>>
>>
>> On 8/15/2023 8:37 AM, Jason Wang wrote:
>>> On Tue, Aug 15, 2023 at 8:26 AM Jason Wang<jasowang@redhat.com>  wrote:
>>>> On Mon, Aug 14, 2023 at 7:29 PM Zhu Lingshan<lingshan.zhu@intel.com>  wrote:
>>>>> This patch introudces a new status bit in the device status: SUSPEND.
>>>>>
>>>>> This SUSPEND bit can be used by the driver to suspend a device,
>>>>> in order to stablize the device states and virtqueue states.
>>>>>
>>>>> Its main use case is live migration.
>>>> I think patch 3 needs to be squashed into this one.
>>>>
>>>>> Signed-off-by: Jason Wang<jasowang@redhat.com>
>>>>> Signed-off-by: Eugenio PÃrez<eperezma@redhat.com>
>>>>> Signed-off-by: Zhu Lingshan<lingshan.zhu@intel.com>
>>>>> ---
>>>>>    content.tex | 18 ++++++++++++++++++
>>>>>    1 file changed, 18 insertions(+)
>>>>>
>>>>> diff --git a/content.tex b/content.tex
>>>>> index 0a62dce..1bb4401 100644
>>>>> --- a/content.tex
>>>>> +++ b/content.tex
>>>>> @@ -47,6 +47,9 @@ \section{\field{Device Status} Field}\label{sec:Basic Facilities of a Virtio Dev
>>>>>    \item[DRIVER_OK (4)] Indicates that the driver is set up and ready to
>>>>>      drive the device.
>>>>>
>>>>> +\item[SUSPEND (16)] When VIRTIO_F_SUSPEND is negotiated, indicates that the
>>>>> +  device has been suspended by the driver.
>>>>> +
>>>>>    \item[DEVICE_NEEDS_RESET (64)] Indicates that the device has experienced
>>>>>      an error from which it can't recover.
>>>>>    \end{description}
>>>>> @@ -73,6 +76,10 @@ \section{\field{Device Status} Field}\label{sec:Basic Facilities of a Virtio Dev
>>>>>    recover by issuing a reset.
>>>>>    \end{note}
>>>>>
>>>>> +The driver MUST NOT set SUSPEND if FEATURES_OK is not set.
>>>>> +
>>>>> +When set SUSPEND, the driver MUST re-read \field{device status} to ensure the SUSPEND bit is set.
>>>>> +
>>>>>    \devicenormative{\subsection}{Device Status Field}{Basic Facilities of a Virtio Device / Device Status Field}
>>>>>
>>>>>    The device MUST NOT consume buffers or send any used buffer
>>>>> @@ -82,6 +89,13 @@ \section{\field{Device Status} Field}\label{sec:Basic Facilities of a Virtio Dev
>>>>>    that a reset is needed.  If DRIVER_OK is set, after it sets DEVICE_NEEDS_RESET, the device
>>>>>    MUST send a device configuration change notification to the driver.
>>>>>
>>>>> +The device MUST ignore SUSPEND if FEATURES_OK is not set.
>>>> Is there any value to allow SUSPEND to be set without DRIVER_OK?
>>>>
>>>>> +
>>>>> +The deivce MUST ignore SUSPEND if VIRTIO_F_SUSPEND is not negotiated.
>>>> typo.
>>>>
>>>> Thanks
>>> Btw, it's not clear to me if driver is allowed to clear this bit.
>> To allow terminate a live migration process or resume from a failed live
>> migration,
>> we allow DRIVER_OK to clear SUSPEND, in patch 1.
> Does this imply DRIVER_OK is cleared during SUSPEND? This seems more
> complicated than simply allowing clearing this bit?
No, SUSPEND does not clears DRIVER_OK, only DRIVER_OK clears SUSPEND.
The spec says: The driver MUST NOT clear a device status bit.
So I think maybe it's better let the device clears SUSPEND.

Thanks
>
> Thanks
>
>> Thanks
>>> Thanks
>>>
>>>>> +
>>>>> +If VIRTIO_F_SUSPEND is negotiated and SUSPEND is set, the device MUST clear SUSPEND
>>>>> +and resumes operation upon DRIVER_OK.
>>>>> +
>>>>>    \section{Feature Bits}\label{sec:Basic Facilities of a Virtio Device / Feature Bits}
>>>>>
>>>>>    Each virtio device offers all the features it understands.  During
>>>>> @@ -872,6 +886,10 @@ \chapter{Reserved Feature Bits}\label{sec:Reserved Feature Bits}
>>>>>           \ref{devicenormative:Basic Facilities of a Virtio Device / Feature Bits} for
>>>>>           handling features reserved for future use.
>>>>>
>>>>> +  \item[VIRTIO_F_SUSPEND(41)] This feature indicates that the driver can
>>>>> +   SUSPEND the device.
>>>>> +   See \ref{sec:Basic Facilities of a Virtio Device / Device Status Field}.
>>>>> +
>>>>>    \end{description}
>>>>>
>>>>>    \drivernormative{\section}{Reserved Feature Bits}{Reserved Feature Bits}
>>>>> --
>>>>> 2.35.3
>>>>>
>>
>> This publicly archived list offers a means to provide input to the
>> OASIS Virtual I/O Device (VIRTIO) TC.
>>
>> In order to verify user consent to the Feedback License terms and
>> to minimize spam in the list archive, subscription is required
>> before posting.
>>
>> Subscribe:virtio-comment-subscribe@lists.oasis-open.org
>> Unsubscribe:virtio-comment-unsubscribe@lists.oasis-open.org
>> List help:virtio-comment-help@lists.oasis-open.org
>> List archive:https://lists.oasis-open.org/archives/virtio-comment/
>> Feedback License:https://www.oasis-open.org/who/ipr/feedback_license.pdf
>> List Guidelines:https://www.oasis-open.org/policies-guidelines/mailing-lists
>> Committee:https://www.oasis-open.org/committees/virtio/
>> Join OASIS:https://www.oasis-open.org/join/
>>

--------------USCDa0JnZ7N3s1imMawTHyAg
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: 8bit

<html>
  <head>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
  </head>
  <body>
    <font face="monospace"><br>
      <br>
    </font>
    <div class="moz-cite-prefix"><font face="monospace">On 8/16/2023
        10:05 AM, Jason Wang wrote:<br>
      </font></div>
    <blockquote type="cite"
cite="mid:CACGkMEvuJ7iBL6NWesi8UO3Vw5216DobkL2bb525Hhh34x3h0w@mail.gmail.com">
      <pre class="moz-quote-pre" wrap="">On Tue, Aug 15, 2023 at 6:50 PM Zhu, Lingshan <a class="moz-txt-link-rfc2396E" href="mailto:lingshan.zhu@intel.com">&lt;lingshan.zhu@intel.com&gt;</a> wrote:
</pre>
      <blockquote type="cite">
        <pre class="moz-quote-pre" wrap="">


On 8/15/2023 8:37 AM, Jason Wang wrote:
</pre>
        <blockquote type="cite">
          <pre class="moz-quote-pre" wrap="">On Tue, Aug 15, 2023 at 8:26 AM Jason Wang <a class="moz-txt-link-rfc2396E" href="mailto:jasowang@redhat.com">&lt;jasowang@redhat.com&gt;</a> wrote:
</pre>
          <blockquote type="cite">
            <pre class="moz-quote-pre" wrap="">On Mon, Aug 14, 2023 at 7:29 PM Zhu Lingshan <a class="moz-txt-link-rfc2396E" href="mailto:lingshan.zhu@intel.com">&lt;lingshan.zhu@intel.com&gt;</a> wrote:
</pre>
            <blockquote type="cite">
              <pre class="moz-quote-pre" wrap="">This patch introudces a new status bit in the device status: SUSPEND.

This SUSPEND bit can be used by the driver to suspend a device,
in order to stablize the device states and virtqueue states.

Its main use case is live migration.
</pre>
            </blockquote>
            <pre class="moz-quote-pre" wrap="">I think patch 3 needs to be squashed into this one.

</pre>
            <blockquote type="cite">
              <pre class="moz-quote-pre" wrap="">Signed-off-by: Jason Wang <a class="moz-txt-link-rfc2396E" href="mailto:jasowang@redhat.com">&lt;jasowang@redhat.com&gt;</a>
Signed-off-by: Eugenio PÃrez <a class="moz-txt-link-rfc2396E" href="mailto:eperezma@redhat.com">&lt;eperezma@redhat.com&gt;</a>
Signed-off-by: Zhu Lingshan <a class="moz-txt-link-rfc2396E" href="mailto:lingshan.zhu@intel.com">&lt;lingshan.zhu@intel.com&gt;</a>
---
  content.tex | 18 ++++++++++++++++++
  1 file changed, 18 insertions(+)

diff --git a/content.tex b/content.tex
index 0a62dce..1bb4401 100644
--- a/content.tex
+++ b/content.tex
@@ -47,6 +47,9 @@ \section{\field{Device Status} Field}\label{sec:Basic Facilities of a Virtio Dev
  \item[DRIVER_OK (4)] Indicates that the driver is set up and ready to
    drive the device.

+\item[SUSPEND (16)] When VIRTIO_F_SUSPEND is negotiated, indicates that the
+  device has been suspended by the driver.
+
  \item[DEVICE_NEEDS_RESET (64)] Indicates that the device has experienced
    an error from which it can't recover.
  \end{description}
@@ -73,6 +76,10 @@ \section{\field{Device Status} Field}\label{sec:Basic Facilities of a Virtio Dev
  recover by issuing a reset.
  \end{note}

+The driver MUST NOT set SUSPEND if FEATURES_OK is not set.
+
+When set SUSPEND, the driver MUST re-read \field{device status} to ensure the SUSPEND bit is set.
+
  \devicenormative{\subsection}{Device Status Field}{Basic Facilities of a Virtio Device / Device Status Field}

  The device MUST NOT consume buffers or send any used buffer
@@ -82,6 +89,13 @@ \section{\field{Device Status} Field}\label{sec:Basic Facilities of a Virtio Dev
  that a reset is needed.  If DRIVER_OK is set, after it sets DEVICE_NEEDS_RESET, the device
  MUST send a device configuration change notification to the driver.

+The device MUST ignore SUSPEND if FEATURES_OK is not set.
</pre>
            </blockquote>
            <pre class="moz-quote-pre" wrap="">Is there any value to allow SUSPEND to be set without DRIVER_OK?

</pre>
            <blockquote type="cite">
              <pre class="moz-quote-pre" wrap="">+
+The deivce MUST ignore SUSPEND if VIRTIO_F_SUSPEND is not negotiated.
</pre>
            </blockquote>
            <pre class="moz-quote-pre" wrap="">typo.

Thanks
</pre>
          </blockquote>
          <pre class="moz-quote-pre" wrap="">Btw, it's not clear to me if driver is allowed to clear this bit.
</pre>
        </blockquote>
        <pre class="moz-quote-pre" wrap="">To allow terminate a live migration process or resume from a failed live
migration,
we allow DRIVER_OK to clear SUSPEND, in patch 1.
</pre>
      </blockquote>
      <pre class="moz-quote-pre" wrap="">
Does this imply DRIVER_OK is cleared during SUSPEND? This seems more
complicated than simply allowing clearing this bit?</pre>
    </blockquote>
    <font face="monospace">No, SUSPEND does not clears DRIVER_OK, only
      DRIVER_OK clears SUSPEND.<br>
      The spec says: <span class="fontstyle0">The driver MUST NOT clear
        a </span><span class="fontstyle2">device status </span><span
        class="fontstyle0">bit.<br>
        So I think maybe it's better let the device clears SUSPEND.<br>
        <br>
        Thanks</span> </font><br style=" font-style: normal;
      font-variant: normal; font-weight: normal; letter-spacing: normal;
      line-height: normal; orphans: 2; text-align: -webkit-auto;
      text-indent: 0px; text-transform: none; white-space: normal;
      widows: 2; word-spacing: 0px; -webkit-text-size-adjust: auto;
      -webkit-text-stroke-width: 0px; ">
    <blockquote type="cite"
cite="mid:CACGkMEvuJ7iBL6NWesi8UO3Vw5216DobkL2bb525Hhh34x3h0w@mail.gmail.com">
      <pre class="moz-quote-pre" wrap="">

Thanks

</pre>
      <blockquote type="cite">
        <pre class="moz-quote-pre" wrap="">
Thanks
</pre>
        <blockquote type="cite">
          <pre class="moz-quote-pre" wrap="">
Thanks

</pre>
          <blockquote type="cite">
            <blockquote type="cite">
              <pre class="moz-quote-pre" wrap="">+
+If VIRTIO_F_SUSPEND is negotiated and SUSPEND is set, the device MUST clear SUSPEND
+and resumes operation upon DRIVER_OK.
+
  \section{Feature Bits}\label{sec:Basic Facilities of a Virtio Device / Feature Bits}

  Each virtio device offers all the features it understands.  During
@@ -872,6 +886,10 @@ \chapter{Reserved Feature Bits}\label{sec:Reserved Feature Bits}
         \ref{devicenormative:Basic Facilities of a Virtio Device / Feature Bits} for
         handling features reserved for future use.

+  \item[VIRTIO_F_SUSPEND(41)] This feature indicates that the driver can
+   SUSPEND the device.
+   See \ref{sec:Basic Facilities of a Virtio Device / Device Status Field}.
+
  \end{description}

  \drivernormative{\section}{Reserved Feature Bits}{Reserved Feature Bits}
--
2.35.3

</pre>
            </blockquote>
          </blockquote>
        </blockquote>
        <pre class="moz-quote-pre" wrap="">

This publicly archived list offers a means to provide input to the
OASIS Virtual I/O Device (VIRTIO) TC.

In order to verify user consent to the Feedback License terms and
to minimize spam in the list archive, subscription is required
before posting.

Subscribe: <a class="moz-txt-link-abbreviated" href="mailto:virtio-comment-subscribe@lists.oasis-open.org">virtio-comment-subscribe@lists.oasis-open.org</a>
Unsubscribe: <a class="moz-txt-link-abbreviated" href="mailto:virtio-comment-unsubscribe@lists.oasis-open.org">virtio-comment-unsubscribe@lists.oasis-open.org</a>
List help: <a class="moz-txt-link-abbreviated" href="mailto:virtio-comment-help@lists.oasis-open.org">virtio-comment-help@lists.oasis-open.org</a>
List archive: <a class="moz-txt-link-freetext" href="https://lists.oasis-open.org/archives/virtio-comment/">https://lists.oasis-open.org/archives/virtio-comment/</a>
Feedback License: <a class="moz-txt-link-freetext" href="https://www.oasis-open.org/who/ipr/feedback_license.pdf">https://www.oasis-open.org/who/ipr/feedback_license.pdf</a>
List Guidelines: <a class="moz-txt-link-freetext" href="https://www.oasis-open.org/policies-guidelines/mailing-lists">https://www.oasis-open.org/policies-guidelines/mailing-lists</a>
Committee: <a class="moz-txt-link-freetext" href="https://www.oasis-open.org/committees/virtio/">https://www.oasis-open.org/committees/virtio/</a>
Join OASIS: <a class="moz-txt-link-freetext" href="https://www.oasis-open.org/join/">https://www.oasis-open.org/join/</a>

</pre>
      </blockquote>
      <pre class="moz-quote-pre" wrap="">
</pre>
    </blockquote>
    <font face="monospace"><br>
    </font>
  </body>
</html>

--------------USCDa0JnZ7N3s1imMawTHyAg--
