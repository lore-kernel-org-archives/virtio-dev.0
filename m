Return-Path: virtio-dev-return-6651-cohuck=redhat.com@lists.oasis-open.org
Sender: <virtio-dev@lists.oasis-open.org>
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id EBCBE985CD4
	for <virtio-dev@lists.oasis-open.org>; Mon, 13 Jan 2020 11:54:11 +0000 (UTC)
References: <1576855504-34947-1-git-send-email-jing2.liu@linux.intel.com>
 <20200106161836.GB350142@stefanha-x1.localdomain>
 <f691fb60-8f59-e827-6a5f-569db29e0a39@linux.intel.com>
 <20200110095217.GB573283@stefanha-x1.localdomain>
From: "Liu, Jing2" <jing2.liu@linux.intel.com>
Message-ID: <801cf09a-759f-b6bf-e71b-02dbf0f1d513@linux.intel.com>
Date: Mon, 13 Jan 2020 19:54:06 +0800
MIME-Version: 1.0
In-Reply-To: <20200110095217.GB573283@stefanha-x1.localdomain>
Content-Language: en-US
Subject: Re: [virtio-dev][PATCH v1 1/2] virtio-mmio: Add MSI and different
 notification address support
Content-Type: multipart/alternative;
 boundary="------------C4BCE6BC214ED945A90613D2"
To: Stefan Hajnoczi <stefanha@redhat.com>
Cc: virtio-dev@lists.oasis-open.org, slp@redhat.com, linux-kernel@vger.kernel.org, Chao Peng <chao.p.peng@linux.intel.com>, Zha Bin <zhabin@linux.alibaba.com>, Liu Jiang <gerry@linux.alibaba.com>
List-ID: <virtio-dev.lists.oasis-open.org>

--------------C4BCE6BC214ED945A90613D2
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable

>>>> @@ -1597,9 +1597,9 @@ \subsection{MMIO Device Register Layout}\label{s=
ec:Virtio Transport Options / Vi
>>>>      }
>>>>      \hline
>>>>      \mmioreg{Version}{Device version number}{0x004}{R}{%
>>>> -    0x2.
>>>> +    0x3.
>>>>        \begin{note}
>>>> -      Legacy devices (see \ref{sec:Virtio Transport Options / Virtio =
Over MMIO / Legacy interface}~\nameref{sec:Virtio Transport Options / Virti=
o Over MMIO / Legacy interface}) used 0x1.
>>>> +      Legacy devices (see \ref{sec:Virtio Transport Options / Virtio =
Over MMIO / Legacy interface}~\nameref{sec:Virtio Transport Options / Virti=
o Over MMIO / Legacy interface}) used 0x1 or 0x2.
>>> "Legacy devices" refers to pre-VIRTIO 1.0 devices.  0x2 is VIRTIO 1.0
>>> and therefore not "Legacy".  I suggest the following wording:
>>>
>>>         Legacy devices (see \ref{sec:Virtio Transport Options / Virtio =
Over MMIO / Legacy interface}~\nameref{sec:Virtio Transport Options / Virti=
o Over MMIO / Legacy interface}) used 0x1.
>>> +     VIRTIO 1.0 and 1.1 used 0x2.
>> Thanks for the guide.
>>> Did you consider using a transport feature bit instead of changing the
>>> device version number?  Feature bits allow more graceful compatibility:
>>> old drivers will continue to work with new devices and new drivers will
>>> continue to work with old devices.
>> Yes, we considered using a feature bit from 24~37 or above, while a conc=
ern
>> is that,
>>
>> the device which uses such bit only represents the behavior of mmio
>> transport layer but not common behavior
>>
>> of virtio device. Or am I missing some "transport" feature bit range?
> https://docs.oasis-open.org/virtio/virtio/v1.1/cs01/virtio-v1.1-cs01.html=
#x1-4100006
>
> Feature bit 39 is reserved and can be used.
>
> This is similar to when the SR_IOV (37) feature bit was added for
> virtio-pci.
That's great. Let's try to use bit 39 for MMIO MSI and bit 40 for MMIO=20
notifications capabilities.
>>>>        \end{note}
>>>>      }
>>>>      \hline
>>>> @@ -1671,25 +1671,23 @@ \subsection{MMIO Device Register Layout}\label=
{sec:Virtio Transport Options / Vi
>>>>        accesses apply to the queue selected by writing to \field{Queue=
Sel}.
>>>>      }
>>>>      \hline
>>>> -  \mmioreg{QueueNotify}{Queue notifier}{0x050}{W}{%
>>>> -    Writing a value to this register notifies the device that
>>>> -    there are new buffers to process in a queue.
>>>> +  \mmioreg{QueueNotify}{Queue notifier}{0x050}{RW}{%
>>>> +    Reading from the register returns the virtqueue notification conf=
iguration.
>>>> -    When VIRTIO_F_NOTIFICATION_DATA has not been negotiated,
>>>> -    the value written is the queue index.
>>>> +    See \ref{sec:Virtio Transport Options / Virtio Over MMIO / MMIO-s=
pecific Initialization And Device Operation / Notification Address}
>>>> +    for the configuration format.
>>>> -    When VIRTIO_F_NOTIFICATION_DATA has been negotiated,
>>>> -    the \field{Notification data} value has the following format:
>>>> +    Writing when the notification address calculated by the notificat=
ion configuration
>>>> +    is just located at this register.
>>> I don't understand this sentence.  What happens when the driver writes
>>> to this register?
>> We're trying to define the notification mechanism that, driver MUST read
>> 0x50 to get the notification configuration
>>
>> and calculate the notify address. The writing case here is that, the not=
ify
>> address is just located here e.g. notify_base=3D0x50, notify_mul=3D0.
> I still don't understand what this means.  It's just an English issue
> and it will become clear if you can rephrase what you're saying.

Sure, let me try to explain it. :)

The different notification locations are calculated via the structure=20
returned by reading this register.

le32 {
 =C2=A0=C2=A0=C2=A0 notify_base : 16;
 =C2=A0=C2=A0=C2=A0 notify_multiplier : 16;
};

location=3Dnotify_base + queue_index * notify_multiplier

The location might be the same when mul=3D0, and furthermore, it might be=
=20
equal to 0x50 (notify_base=3D0x50, notify_mul=3D0) so we make this register=
=20
W too.

So we said, the register is RW and W is only for such scenario.

Feel free to tell me if it's still confusing.

>>>> -    \lstinputlisting{notifications-le.c}
>>>> -
>>>> -    See \ref{sec:Virtqueues / Driver notifications}~\nameref{sec:Virt=
queues / Driver notifications}
>>>> -    for the definition of the components.
>>>> +    See \ref{sec:Virtio Transport Options / Virtio Over MMIO / MMIO-s=
pecific Initialization And Device Operation / Available Buffer Notification=
s}
>>>> +    to see the notification data format.
>>>>      }
>>>>      \hline
>>>>      \mmioreg{InterruptStatus}{Interrupt status}{0x60}{R}{%
>>>>        Reading from this register returns a bit mask of events that
>>>> -    caused the device interrupt to be asserted.
>>>> +    caused the device interrupt to be asserted. This is only used
>>>> +    when MSI is not enabled.
>>>>        The following events are possible:
>>>>        \begin{description}
>>>>          \item[Used Buffer Notification] - bit 0 - the interrupt was a=
sserted
>>>> @@ -1703,7 +1701,7 @@ \subsection{MMIO Device Register Layout}\label{s=
ec:Virtio Transport Options / Vi
>>>>      \mmioreg{InterruptACK}{Interrupt acknowledge}{0x064}{W}{%
>>>>        Writing a value with bits set as defined in \field{InterruptSta=
tus}
>>>>        to this register notifies the device that events causing
>>>> -    the interrupt have been handled.
>>>> +    the interrupt have been handled. This is only used when MSI is no=
t enabled.
>>>>      }
>>>>      \hline
>>>>      \mmioreg{Status}{Device status}{0x070}{RW}{%
>>>> @@ -1762,6 +1760,31 @@ \subsection{MMIO Device Register Layout}\label{=
sec:Virtio Transport Options / Vi
>>>>        \field{SHMSel} is unused) results in a base address of
>>>>        0xffffffffffffffff.
>>>>      }
>>>> +  \hline
>>>> +  \mmioreg{MsiStatus}{MSI status}{0x0c0}{R}{%
>>>> +    Reading from this register returns the global MSI enable/disable =
status and maximum
>>>> +    number of virtqueues that device supports.
>>>> +    \lstinputlisting{msi-status.c}
>>>> +  }
>>> Why is it necessary to combine the number of virtqueues and global
>>> MSI enable/disable into a single 16-bit field?
>> Originally, we want this 16-bit Read-Only, so we put some RO things toge=
ther
>> and separate
>>
>> enable setting command to next register.
>>
>>> virtio-mmio uses 32-bit registers.  It doesn't try hard to save registe=
r
>>> space so it's strange to do it here (11-bit number of virtqueue field
>>> but 32-bit QueueSel field).
>> In order to improve performance/save register space,=C2=A0 we combine so=
me data
>> together.
>>
>> For example, combine MSI cmd operator (e.g. enable/disable, vector setup=
)
>> with argument (e.g. 1/0,=C2=A0 queue index).
>>
>> But it seems we miss the consistency with QueueSel.=C2=A0 So do you thin=
k if the
>> max queue number should be 32-bit,
>>
>> which means it must be the same with QueueSel? If so, I guess we need so=
me
>> re-organization. :)
> I suggest following the 32-bit register size convention unless there is
> a specific reason why using other register sizes is absolutely necessary.

Yes, let's keep consistency with QueueSel and re-organize other registers.

I feel concern why Available Bu=EF=AC=80er Notifcations (section describing=
=20
VIRTIO_F_NOTIFICATION_DATA) makes vq index as 16bit?

>>>> +  \hline
>>>> +  \mmioreg{MsiCmd}{MSI command}{0x0c2}{W}{%
>>>> +    The driver writes to this register with appropriate operators and=
 arguments to
>>>> +    execute MSI command to device.
>>>> +    Operators supported is setting global MSI enable/disable status
>>>> +    and updating MSI configuration to device.
>>> If the global MSI enable/disable state is written in this register,
>>> consider making this register readable too so the global MSI
>>> enable/disable state can be read from it.
>> Read enable/disable state is in 0x0c0.
> The read-only 0xc0 register combines two pieces of information:
> 1. Global MSI enable/disable state
> 2. Number of virtqueues (or is "number of MSI vectors" a more accurate
>     term?)
>
> A simpler way of organizing the registers is:
> MsiMaxVectors R
> MsiState RW
>
> This is simpler because drivers can read the MsiMaxVectors field and
> treat the value as an integer (no masking required).  And a person
> reading the specification instantly knows how to fetch the MSI
> enable/disable state when they read the MsiState register description.
> They don't need to look through all the other registers to find the one
> that allows them to read the state.

That's a good idea to separate the MsiMaxVectors(32bit) and this also=20
meets the request from Jason/MST's comments.

Thanks!

Jing

>
> Stefan

--------------C4BCE6BC214ED945A90613D2
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<html>
  <head>
    <meta http-equiv=3D"Content-Type" content=3D"text/html; charset=3DUTF-8=
">
  </head>
  <body>
    <blockquote type=3D"cite"
      cite=3D"mid:20200110095217.GB573283@stefanha-x1.localdomain">
      <blockquote type=3D"cite">
        <blockquote type=3D"cite">
          <blockquote type=3D"cite">
            <pre class=3D"moz-quote-pre" wrap=3D"">@@ -1597,9 +1597,9 @@ \s=
ubsection{MMIO Device Register Layout}\label{sec:Virtio Transport Options /=
 Vi
    }
    \hline
    \mmioreg{Version}{Device version number}{0x004}{R}{%
-    0x2.
+    0x3.
      \begin{note}
-      Legacy devices (see \ref{sec:Virtio Transport Options / Virtio Over =
MMIO / Legacy interface}~\nameref{sec:Virtio Transport Options / Virtio Ove=
r MMIO / Legacy interface}) used 0x1.
+      Legacy devices (see \ref{sec:Virtio Transport Options / Virtio Over =
MMIO / Legacy interface}~\nameref{sec:Virtio Transport Options / Virtio Ove=
r MMIO / Legacy interface}) used 0x1 or 0x2.
</pre>
          </blockquote>
          <pre class=3D"moz-quote-pre" wrap=3D"">"Legacy devices" refers to=
 pre-VIRTIO 1.0 devices.  0x2 is VIRTIO 1.0
and therefore not "Legacy".  I suggest the following wording:

       Legacy devices (see \ref{sec:Virtio Transport Options / Virtio Over =
MMIO / Legacy interface}~\nameref{sec:Virtio Transport Options / Virtio Ove=
r MMIO / Legacy interface}) used 0x1.
+     VIRTIO 1.0 and 1.1 used 0x2.
</pre>
        </blockquote>
        <pre class=3D"moz-quote-pre" wrap=3D"">Thanks for the guide.
</pre>
        <blockquote type=3D"cite">
          <pre class=3D"moz-quote-pre" wrap=3D"">Did you consider using a t=
ransport feature bit instead of changing the
device version number?  Feature bits allow more graceful compatibility:
old drivers will continue to work with new devices and new drivers will
continue to work with old devices.
</pre>
        </blockquote>
        <pre class=3D"moz-quote-pre" wrap=3D"">
Yes, we considered using a feature bit from 24~37 or above, while a concern
is that,

the device which uses such bit only represents the behavior of mmio
transport layer but not common behavior

of virtio device. Or am I missing some "transport" feature bit range?
</pre>
      </blockquote>
      <pre class=3D"moz-quote-pre" wrap=3D"">
<a class=3D"moz-txt-link-freetext" href=3D"https://docs.oasis-open.org/virt=
io/virtio/v1.1/cs01/virtio-v1.1-cs01.html#x1-4100006">https://docs.oasis-op=
en.org/virtio/virtio/v1.1/cs01/virtio-v1.1-cs01.html#x1-4100006</a>

Feature bit 39 is reserved and can be used.

This is similar to when the SR_IOV (37) feature bit was added for
virtio-pci.
</pre>
    </blockquote>
    That's great. Let's try to use bit 39 for MMIO MSI and bit 40 for
    MMIO notifications capabilities.<br>
    <blockquote type=3D"cite"
      cite=3D"mid:20200110095217.GB573283@stefanha-x1.localdomain">
      <pre class=3D"moz-quote-pre" wrap=3D"">
</pre>
      <blockquote type=3D"cite">
        <blockquote type=3D"cite">
          <blockquote type=3D"cite">
            <pre class=3D"moz-quote-pre" wrap=3D"">      \end{note}
    }
    \hline
@@ -1671,25 +1671,23 @@ \subsection{MMIO Device Register Layout}\label{sec:=
Virtio Transport Options / Vi
      accesses apply to the queue selected by writing to \field{QueueSel}.
    }
    \hline
-  \mmioreg{QueueNotify}{Queue notifier}{0x050}{W}{%
-    Writing a value to this register notifies the device that
-    there are new buffers to process in a queue.
+  \mmioreg{QueueNotify}{Queue notifier}{0x050}{RW}{%
+    Reading from the register returns the virtqueue notification configura=
tion.
-    When VIRTIO_F_NOTIFICATION_DATA has not been negotiated,
-    the value written is the queue index.
+    See \ref{sec:Virtio Transport Options / Virtio Over MMIO / MMIO-specif=
ic Initialization And Device Operation / Notification Address}
+    for the configuration format.
-    When VIRTIO_F_NOTIFICATION_DATA has been negotiated,
-    the \field{Notification data} value has the following format:
+    Writing when the notification address calculated by the notification c=
onfiguration
+    is just located at this register.
</pre>
          </blockquote>
          <pre class=3D"moz-quote-pre" wrap=3D"">I don't understand this se=
ntence.  What happens when the driver writes
to this register?
</pre>
        </blockquote>
        <pre class=3D"moz-quote-pre" wrap=3D"">
We're trying to define the notification mechanism that, driver MUST read
0x50 to get the notification configuration

and calculate the notify address. The writing case here is that, the notify
address is just located here e.g. notify_base=3D0x50, notify_mul=3D0.
</pre>
      </blockquote>
      <pre class=3D"moz-quote-pre" wrap=3D"">
I still don't understand what this means.  It's just an English issue
and it will become clear if you can rephrase what you're saying.
</pre>
    </blockquote>
    <p>Sure, let me try to explain it. :)<br>
    </p>
    <p>The different notification locations are calculated via the
      structure returned by reading this register.<br>
    </p>
    <p><span class=3D"fontstyle0">le32 {<br>
        =C2=A0=C2=A0=C2=A0 notify_base : 16;<br>
        =C2=A0=C2=A0=C2=A0 notify_multiplier : 16;<br>
        };</span> <br style=3D" font-style: normal; font-variant: normal;
        font-weight: normal; letter-spacing: normal; line-height:
        normal; orphans: 2; text-align: -webkit-auto; text-indent: 0px;
        text-transform: none; white-space: normal; widows: 2;
        word-spacing: 0px; -webkit-text-size-adjust: auto;
        -webkit-text-stroke-width: 0px; ">
    </p>
    <p>location=3D<span class=3D"fontstyle0">notify_base + queue_index *
        notify_multiplier</span> <br>
    </p>
    <p>The location might be the same when mul=3D0, and furthermore, it
      might be equal to 0x50 (notify_base=3D0x50, notify_mul=3D0) so we mak=
e
      this register W too. <br>
    </p>
    <p>So we said, the register is RW and W is only for such scenario.<br>
    </p>
    <p>Feel free to tell me if it's still confusing.<br style=3D"
        font-style: normal; font-variant: normal; font-weight: normal;
        letter-spacing: normal; line-height: normal; orphans: 2;
        text-align: -webkit-auto; text-indent: 0px; text-transform:
        none; white-space: normal; widows: 2; word-spacing: 0px;
        -webkit-text-size-adjust: auto; -webkit-text-stroke-width: 0px;
        ">
    </p>
    <blockquote type=3D"cite"
      cite=3D"mid:20200110095217.GB573283@stefanha-x1.localdomain">
      <pre class=3D"moz-quote-pre" wrap=3D"">
</pre>
      <blockquote type=3D"cite">
        <blockquote type=3D"cite">
          <blockquote type=3D"cite">
            <pre class=3D"moz-quote-pre" wrap=3D"">-    \lstinputlisting{no=
tifications-le.c}
-
-    See \ref{sec:Virtqueues / Driver notifications}~\nameref{sec:Virtqueue=
s / Driver notifications}
-    for the definition of the components.
+    See \ref{sec:Virtio Transport Options / Virtio Over MMIO / MMIO-specif=
ic Initialization And Device Operation / Available Buffer Notifications}
+    to see the notification data format.
    }
    \hline
    \mmioreg{InterruptStatus}{Interrupt status}{0x60}{R}{%
      Reading from this register returns a bit mask of events that
-    caused the device interrupt to be asserted.
+    caused the device interrupt to be asserted. This is only used
+    when MSI is not enabled.
      The following events are possible:
      \begin{description}
        \item[Used Buffer Notification] - bit 0 - the interrupt was asserte=
d
@@ -1703,7 +1701,7 @@ \subsection{MMIO Device Register Layout}\label{sec:Vi=
rtio Transport Options / Vi
    \mmioreg{InterruptACK}{Interrupt acknowledge}{0x064}{W}{%
      Writing a value with bits set as defined in \field{InterruptStatus}
      to this register notifies the device that events causing
-    the interrupt have been handled.
+    the interrupt have been handled. This is only used when MSI is not ena=
bled.
    }
    \hline
    \mmioreg{Status}{Device status}{0x070}{RW}{%
@@ -1762,6 +1760,31 @@ \subsection{MMIO Device Register Layout}\label{sec:V=
irtio Transport Options / Vi
      \field{SHMSel} is unused) results in a base address of
      0xffffffffffffffff.
    }
+  \hline
+  \mmioreg{MsiStatus}{MSI status}{0x0c0}{R}{%
+    Reading from this register returns the global MSI enable/disable statu=
s and maximum
+    number of virtqueues that device supports.
+    \lstinputlisting{msi-status.c}
+  }
</pre>
          </blockquote>
          <pre class=3D"moz-quote-pre" wrap=3D"">Why is it necessary to com=
bine the number of virtqueues and global
MSI enable/disable into a single 16-bit field?
</pre>
        </blockquote>
        <pre class=3D"moz-quote-pre" wrap=3D"">
Originally, we want this 16-bit Read-Only, so we put some RO things togethe=
r
and separate

enable setting command to next register.

</pre>
        <blockquote type=3D"cite">
          <pre class=3D"moz-quote-pre" wrap=3D"">virtio-mmio uses 32-bit re=
gisters.  It doesn't try hard to save register
space so it's strange to do it here (11-bit number of virtqueue field
but 32-bit QueueSel field).
</pre>
        </blockquote>
        <pre class=3D"moz-quote-pre" wrap=3D"">
In order to improve performance/save register space,=C2=A0 we combine some =
data
together.

For example, combine MSI cmd operator (e.g. enable/disable, vector setup)
with argument (e.g. 1/0,=C2=A0 queue index).

But it seems we miss the consistency with QueueSel.=C2=A0 So do you think i=
f the
max queue number should be 32-bit,

which means it must be the same with QueueSel? If so, I guess we need some
re-organization. :)
</pre>
      </blockquote>
      <pre class=3D"moz-quote-pre" wrap=3D"">
I suggest following the 32-bit register size convention unless there is
a specific reason why using other register sizes is absolutely necessary.
</pre>
    </blockquote>
    <p>Yes, let's keep consistency with QueueSel and re-organize other
      registers.</p>
    <p>I feel concern why Available Bu=EF=AC=80er Notifcations (section
      describing VIRTIO_F_NOTIFICATION_DATA) makes vq index as 16bit?<br>
    </p>
    <blockquote type=3D"cite"
      cite=3D"mid:20200110095217.GB573283@stefanha-x1.localdomain">
      <pre class=3D"moz-quote-pre" wrap=3D"">
</pre>
      <blockquote type=3D"cite">
        <blockquote type=3D"cite">
          <pre class=3D"moz-quote-pre" wrap=3D"">
</pre>
          <blockquote type=3D"cite">
            <pre class=3D"moz-quote-pre" wrap=3D"">+  \hline
+  \mmioreg{MsiCmd}{MSI command}{0x0c2}{W}{%
+    The driver writes to this register with appropriate operators and argu=
ments to
+    execute MSI command to device.
+    Operators supported is setting global MSI enable/disable status
+    and updating MSI configuration to device.
</pre>
          </blockquote>
          <pre class=3D"moz-quote-pre" wrap=3D"">If the global MSI enable/d=
isable state is written in this register,
consider making this register readable too so the global MSI
enable/disable state can be read from it.
</pre>
        </blockquote>
        <pre class=3D"moz-quote-pre" wrap=3D"">
Read enable/disable state is in 0x0c0.
</pre>
      </blockquote>
      <pre class=3D"moz-quote-pre" wrap=3D"">
The read-only 0xc0 register combines two pieces of information:
1. Global MSI enable/disable state
2. Number of virtqueues (or is "number of MSI vectors" a more accurate
   term?)

A simpler way of organizing the registers is:
MsiMaxVectors R
MsiState RW

This is simpler because drivers can read the MsiMaxVectors field and
treat the value as an integer (no masking required).  And a person
reading the specification instantly knows how to fetch the MSI
enable/disable state when they read the MsiState register description.
They don't need to look through all the other registers to find the one
that allows them to read the state.</pre>
    </blockquote>
    <p>That's a good idea to separate the MsiMaxVectors(32bit) and this
      also meets the request from Jason/MST's comments.</p>
    <p>Thanks!</p>
    <p>Jing<br>
    </p>
    <blockquote type=3D"cite"
      cite=3D"mid:20200110095217.GB573283@stefanha-x1.localdomain">
      <pre class=3D"moz-quote-pre" wrap=3D"">

Stefan
</pre>
    </blockquote>
  </body>
</html>

--------------C4BCE6BC214ED945A90613D2--

