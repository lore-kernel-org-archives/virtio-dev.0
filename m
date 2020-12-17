Return-Path: virtio-comment-return-1561-cohuck=redhat.com@lists.oasis-open.org
Sender: <virtio-comment@lists.oasis-open.org>
List-Post: <mailto:virtio-comment@lists.oasis-open.org>
List-Help: <mailto:virtio-comment-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-comment-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-comment-subscribe@lists.oasis-open.org>
References: <1ea117ebe46d105eda21544acf85a5c7dbe2d8ec.1606283457.git.jie.deng@intel.com>
 <20201216183859.1e7b206a.cohuck@redhat.com>
 <20201216144343-mutt-send-email-mst@kernel.org>
From: Jie Deng <jie.deng@intel.com>
Message-ID: <7a01ea49-6fdf-ca7a-c504-753865d585e5@intel.com>
Date: Thu, 17 Dec 2020 16:38:54 +0800
MIME-Version: 1.0
In-Reply-To: <20201216144343-mutt-send-email-mst@kernel.org>
Subject: Re: [virtio-comment] [PATCH v5] virtio-i2c: add the device
 specification
Content-Type: multipart/alternative;
 boundary="------------CCB8D35CFD9FF0937FD31D3D"
Content-Language: en-US
To: "Michael S. Tsirkin" <mst@redhat.com>, Cornelia Huck <cohuck@redhat.com>
Cc: virtio-comment@lists.oasis-open.org, virtio-dev@lists.oasis-open.org, pbonzini@redhat.com, kraxel@redhat.com, wsa+renesas@sang-engineering.com, andriy.shevchenko@linux.intel.com, conghui.chen@intel.com, yu1.wang@intel.com, shuo.a.liu@intel.com
List-ID: <virtio-dev.lists.oasis-open.org>

--------------CCB8D35CFD9FF0937FD31D3D
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: quoted-printable


On 2020/12/17 3:55, Michael S. Tsirkin wrote:
> On Wed, Dec 16, 2020 at 06:38:59PM +0100, Cornelia Huck wrote:
>> On Wed, 25 Nov 2020 13:55:18 +0800
>> Jie Deng <jie.deng@intel.com> wrote:
>>
>> <some mostly editorial comments; sorry about bringing this up now>
>>
>>> virtio-i2c is a virtual I2C adapter device. It provides a way
>>> to =EF=AC=82exibly communicate with the host I2C slave devices from
>> s/=EF=AC=82exibly/flexibly/
>>
>>> the guest.
>>>
>>> This patch adds the specification for this device.
>>>
>>> Fixes: https://github.com/oasis-tcs/virtio-spec/issues/88
>>> Signed-off-by: Jie Deng <jie.deng@intel.com>
>
> Given the comments do we want to

I didn't get it. Can you explain more?

>
>>> ---
>>>   conformance.tex  |  28 +++++++++--
>>>   content.tex      |   1 +
>>>   introduction.tex |   3 ++
>>>   virtio-i2c.tex   | 139 ++++++++++++++++++++++++++++++++++++++++++++++=
+++++++++
>>>   4 files changed, 167 insertions(+), 4 deletions(-)
>>>   create mode 100644 virtio-i2c.tex
>>>
>> (...)
>>
>>
>>> diff --git a/introduction.tex b/introduction.tex
>>> index cc38e29..9f016d5 100644
>>> --- a/introduction.tex
>>> +++ b/introduction.tex
>>> @@ -73,6 +73,9 @@ \section{Normative References}\label{sec:Normative Re=
ferences}
>>>   =09\phantomsection\label{intro:HDA}\textbf{[HDA]} &
>>>   =09High Definition Audio Specification,
>>>   =09\newline\url{https://www.intel.com/content/dam/www/public/us/en/do=
cuments/product-specifications/high-definition-audio-specification.pdf}\\
>>> +=09\phantomsection\label{intro:I2C}\textbf{[I2C]} &
>>> +=09I2C-bus specification and user manual,
>>> +=09\newline\url{https://www.nxp.com.cn/docs/en/user-guide/UM10204.pdf}=
\\
>> I think this url should use www.nxp.com instead of www.nxp.com.cn (even
>> though both seem to lead to the same document).
>>
>>>  =20
>>>   \end{longtable}
>>>  =20
>>> diff --git a/virtio-i2c.tex b/virtio-i2c.tex
>>> new file mode 100644
>>> index 0000000..fdb0050
>>> --- /dev/null
>>> +++ b/virtio-i2c.tex
>>> @@ -0,0 +1,139 @@
>>> +\section{I2C Adapter Device}\label{sec:Device Types / I2C Adapter Devi=
ce}
>>> +
>>> +virtio-i2c is a virtual I2C adapter device.
> BTW is this neessarily a virtual device? One can build a physical
> one to this spec, no?
The virtio-i2c is a virtual I2C master device. One can attach a host=20
physical
slave I2C device to this virtual device.
>
>> It provides a way to flexibly
>>> +organize and use the host I2C slave devices from the guest. By attachi=
ng
>>> +the host ACPI I2C slave nodes to the virtual I2C adapter device, the g=
uest can
>>> +communicate with them without changing or adding extra drivers for the=
se
>>> +slave I2C devices.
>> I know that the i2c spec talks about 'slave' devices, but can we find a
>> better terminology for the virtio standard? E.g. prefix this with
>>
>> "Note: This standard uses the term 'controlled I2C device' to refer to
>> what the I2C standard calls 'slave I2C device'."
>>
>> (Or whatever better term might exist.)
>>
>>> +
>>> +\subsection{Device ID}\label{sec:Device Types / I2C Adapter Device / D=
evice ID}
>>> +34
>>> +
>>> +\subsection{Virtqueues}\label{sec:Device Types / I2C Adapter Device / =
Virtqueues}
>>> +
>>> +\begin{description}
>>> +\item[0] requestq
>>> +\end{description}
>>> +
>>> +\subsection{Feature bits}\label{sec:Device Types / I2C Adapter Device =
/ Feature bits}
>>> +
>>> +None currently defined.
>>> +
>>> +\subsection{Device configuration layout}\label{sec:Device Types / I2C =
Adapter Device / Device configuration layout}
>>> +
>>> +None currently defined.
>>> +
>>> +\subsection{Device Initialization}\label{sec:Device Types / I2C Adapte=
r Device / Device Initialization}
>>> +
>>> +\begin{enumerate}
>>> +\item The virtqueue is initialized.
>>> +\end{enumerate}
>>> +
>>> +\subsection{Device Operation}\label{sec:Device Types / I2C Adapter Dev=
ice / Device Operation}
>>> +
>>> +\subsubsection{Device Operation: Request Queue}\label{sec:Device Types=
 / I2C Adapter Device / Device Operation: Request Queue}
>>> +
>>> +The driver queues requests to the virtqueue, and they are used by the
>>> +device. The request is the representation of segments of an I2C
>>> +transaction. Each request is of form:
> of the form
Will fix it.
>>> +
>>> +\begin{lstlisting}
>>> +struct virtio_i2c_req {
>>> +        le16 addr;
>>> +        le32 flags;
>>> +        le16 written;
>>> +        le16 read;
>>> +        u8 write_buf[];
>>> +        u8 read_buf[];
>>> +        u8 status;
>>> +};
>>> +\end{lstlisting}
>>> +
>>> +The \field{addr} of the request is the address of the I2C slave device=
.
>>> +
>>> +The \field{flags} of the request is currently reserved as zero for fut=
ure
>>> +feature extensibility.
>>> +
>>> +The \field{written} of the request is the number of data bytes in the =
\field{write_buf}
>>> +being written to the I2C slave address.
>>> +
>>> +The \field{read} of the request is the number of data bytes in the \fi=
eld{read_buf}
>>> +being read from the I2C slave address.
> I note that read and written actually duplicate buf size
> available in the descriptor.
> Given we no longer mirror i2c_msg 1:1 do we still want to do this?
> It will be trivial for the host device to populate these fields
> correctly for linux.
> Duplication of information iten leads to errors ...
Got it. I'm OK to remove read and written and use the size in the=20
descriptor.
>
>>> +
>>> +The \field{write_buf} of the request contains one segment of an I2C tr=
ansaction
>>> +being written to the device.
>>> +
>>> +The \field{read_buf} of the request contains one segment of an I2C tra=
nsaction
>>> +being read from the device.
>>> +
>>> +The final \field{status} byte of the request is written by the device:=
 either
>>> +VIRTIO_I2C_MSG_OK for success or VIRTIO_I2C_MSG_ERR for error.
>>> +
>>> +\begin{lstlisting}
>>> +#define VIRTIO_I2C_MSG_OK     0
>>> +#define VIRTIO_I2C_MSG_ERR    1
>>> +\end{lstlisting}
>>> +
>>> +If the \field{read}=3D0 and the \field{written}>0, the request is call=
ed write request.
>>> +
>>> +If the \field{read}>0 and the \field{written}=3D0, the request is call=
ed read request.
>>> +
>>> +If the \field{read}>0 and the \field{written}>0, the request is called=
 write-read request.
>>> +It means an I2C write segment followed by a read segment. Usually, the=
 write segment
>>> +provides the number of an I2C slave device register to be read.
>>> +
>>> +The \field{read}=3D0 and at the same time the \field{written}=3D0 does=
n't make any sense.
>>> +The driver SHOULD never send such request.
>> 'SHOULD' makes this a normative statement.
>>
>>> +
>>> +\subsubsection{Device Operation: Operation Status}\label{sec:Device Ty=
pes / I2C Adapter Device / Device Operation: Operation Status}
>>> +
>>> +A driver may send one request or multiple requests to the device at a =
time.
>>> +The requests in the virtqueue MUST be queued and processed in order.
>> Same here, 'MUST' makes this a normative statement. I think lowercasing
>> these terms would make it correct.
>>
>
> It won't, the relevant rfc includes MUST and must etc.
>
> If this is normative move it to a normative statement.
> Or preferably, both change this to e.g.
>
> The requests in the virtqueue are both queued and processed in order.
>
> and add a normative statement in the normative section.
>
OK. Will fix it.
>>> +
>>> +If a driver sends multiple requests at a time and a device fails to pr=
ocess
>>> +some of them, then the first failed request MUST have its \field{statu=
s}
>>> +being set to VIRTIO_I2C_MSG_ERR by the device and the requests after t=
he first
>>> +failed one MUST also be treated as VIRTIO_I2C_MSG_ERR by the driver,
>>> +no matter what \field{status} of them. In this case, the number of suc=
cessfully
>>> +sent requests this time is the number of the last request being succes=
sfully
>>> +processed.
>>> +
>>> +\drivernormative{\subsubsection}{Device Operation}{Device Types / I2C =
Adapter Device / Device Operation}
>>> +
>>> +A driver MUST set \field{addr}, \field{flags}(currently reserved as ze=
ro),
>> I'd drop "(currently reserved as zero)" here and add
>>
>> "A driver MUST set \field{flags} to zero."
>>
>>
>>> +\field{written} and \field{read} before sending the request.
>>> +
>>> +A driver MUST place one segment of an I2C transaction into \field{writ=
e_buf} if the
>> s/if the/if/
>>
>>> +\field{written}>0.
>>> +
>>> +A driver MUST NOT use \field{read_buf} if the final \field{status} ret=
urned
>>> +from the device is VIRTIO_I2C_MSG_ERR.
>>> +
>>> +A driver MAY queue one request or multiple requests at a time.
>>> +
>>> +A driver MUST queue the requests in order if multiple requests are goi=
ng to
>>> +be sent at a time.
>>> +
>>> +If multiple requests are sent at a time and some of them returned from=
 the
>>> +device have the \field{status} being VIRTIO_I2C_MSG_ERR, a driver MUST=
 treat
>>> +the first failed request and the requests after the first failed one a=
s
>>> +VIRTIO_I2C_MSG_ERR.
>>> +
>>> +\devicenormative{\subsubsection}{Device Operation}{Device Types / I2C =
Adapter Device / Device Operation}
>>> +
>>> +A device SHOULD keep consistent behaviors with the hardware as describ=
ed in
>>> +\hyperref[intro:I2C]{I2C}.
>>> +
>>> +A device MUST NOT change the value of \field{addr}, \field{flags}, \fi=
eld{written},
>>> +\field{read} and \field{write_buf}.
>>> +
>>> +A device MUST place one segment of an I2C transaction into \field{read=
_buf} if the
>> s/if/if the/
>>
>>> +\field{read}>0.
>>> +
>>> +A device MUST guarantee the requests in the virtqueue being processed =
in order
>>> +if multiple requests are received at a time.
>>> +
>>> +If multiple requests are received at a time and some of them being pro=
cessed failed,
> and processing of some of the requests fails
Will fix it.
>>> +a device MUST set the \field{status} of the first failed request to be
>>> +VIRTIO_I2C_MSG_ERR and MAY set the \field{status} of the requests afte=
r
>>> +the first failed one to be VIRTIO_I2C_MSG_ERR.
> So what is it saying? That VIRTIO_I2C_MSG_ERR can also mean
> "previous request failed"?

It means if for example 5 requests are sent and received with
req3 failed.Since the driver musttreat the first failed request (req3) and =
the requests after the first=20
failed one (req4 and req5) as VIRTIO_I2C_MSG_ERR.

So we don't need to care about the status of the req4 and req5 if req3 fail=
ed.They will
be treated as failed no matter what status.
 =20
req1(OK)  req2(OK)  req3(FAIL)  req4  req5


--------------CCB8D35CFD9FF0937FD31D3D
Content-Type: text/html; charset=utf-8
Content-Transfer-Encoding: quoted-printable

<html>
  <head>
    <meta http-equiv=3D"Content-Type" content=3D"text/html; charset=3DUTF-8=
">
  </head>
  <body>
    <p><br>
    </p>
    <div class=3D"moz-cite-prefix">On 2020/12/17 3:55, Michael S. Tsirkin
      wrote:<br>
    </div>
    <blockquote type=3D"cite"
      cite=3D"mid:20201216144343-mutt-send-email-mst@kernel.org">
      <pre class=3D"moz-quote-pre" wrap=3D"">On Wed, Dec 16, 2020 at 06:38:=
59PM +0100, Cornelia Huck wrote:
</pre>
      <blockquote type=3D"cite">
        <pre class=3D"moz-quote-pre" wrap=3D"">On Wed, 25 Nov 2020 13:55:18=
 +0800
Jie Deng <a class=3D"moz-txt-link-rfc2396E" href=3D"mailto:jie.deng@intel.c=
om">&lt;jie.deng@intel.com&gt;</a> wrote:

&lt;some mostly editorial comments; sorry about bringing this up now&gt;

</pre>
        <blockquote type=3D"cite">
          <pre class=3D"moz-quote-pre" wrap=3D"">virtio-i2c is a virtual I2=
C adapter device. It provides a way
to =EF=AC=82exibly communicate with the host I2C slave devices from
</pre>
        </blockquote>
        <pre class=3D"moz-quote-pre" wrap=3D"">
s/=EF=AC=82exibly/flexibly/

</pre>
        <blockquote type=3D"cite">
          <pre class=3D"moz-quote-pre" wrap=3D"">the guest.

This patch adds the specification for this device.

Fixes: <a class=3D"moz-txt-link-freetext" href=3D"https://github.com/oasis-=
tcs/virtio-spec/issues/88">https://github.com/oasis-tcs/virtio-spec/issues/=
88</a>
Signed-off-by: Jie Deng <a class=3D"moz-txt-link-rfc2396E" href=3D"mailto:j=
ie.deng@intel.com">&lt;jie.deng@intel.com&gt;</a>
</pre>
        </blockquote>
      </blockquote>
      <pre class=3D"moz-quote-pre" wrap=3D"">

Given the comments do we want to </pre>
    </blockquote>
    <p>I didn't get it. Can you explain more?<br>
    </p>
    <blockquote type=3D"cite"
      cite=3D"mid:20201216144343-mutt-send-email-mst@kernel.org">
      <pre class=3D"moz-quote-pre" wrap=3D"">

</pre>
      <blockquote type=3D"cite">
        <blockquote type=3D"cite">
          <pre class=3D"moz-quote-pre" wrap=3D"">---
 conformance.tex  |  28 +++++++++--
 content.tex      |   1 +
 introduction.tex |   3 ++
 virtio-i2c.tex   | 139 +++++++++++++++++++++++++++++++++++++++++++++++++++=
++++
 4 files changed, 167 insertions(+), 4 deletions(-)
 create mode 100644 virtio-i2c.tex

</pre>
        </blockquote>
        <pre class=3D"moz-quote-pre" wrap=3D"">
(...)


</pre>
        <blockquote type=3D"cite">
          <pre class=3D"moz-quote-pre" wrap=3D"">diff --git a/introduction.=
tex b/introduction.tex
index cc38e29..9f016d5 100644
--- a/introduction.tex
+++ b/introduction.tex
@@ -73,6 +73,9 @@ \section{Normative References}\label{sec:Normative Refere=
nces}
 =09\phantomsection\label{intro:HDA}\textbf{[HDA]} &amp;
 =09High Definition Audio Specification,
 =09\newline\url{<a class=3D"moz-txt-link-freetext" href=3D"https://www.int=
el.com/content/dam/www/public/us/en/documents/product-specifications/high-d=
efinition-audio-specification.pdf">https://www.intel.com/content/dam/www/pu=
blic/us/en/documents/product-specifications/high-definition-audio-specifica=
tion.pdf</a>}\\
+=09\phantomsection\label{intro:I2C}\textbf{[I2C]} &amp;
+=09I2C-bus specification and user manual,
+=09\newline\url{<a class=3D"moz-txt-link-freetext" href=3D"https://www.nxp=
.com.cn/docs/en/user-guide/UM10204.pdf">https://www.nxp.com.cn/docs/en/user=
-guide/UM10204.pdf</a>}\\
</pre>
        </blockquote>
        <pre class=3D"moz-quote-pre" wrap=3D"">
I think this url should use <a class=3D"moz-txt-link-abbreviated" href=3D"h=
ttp://www.nxp.com">www.nxp.com</a> instead of <a class=3D"moz-txt-link-abbr=
eviated" href=3D"http://www.nxp.com.cn">www.nxp.com.cn</a> (even
though both seem to lead to the same document).

</pre>
        <blockquote type=3D"cite">
          <pre class=3D"moz-quote-pre" wrap=3D"">=20
 \end{longtable}
=20
diff --git a/virtio-i2c.tex b/virtio-i2c.tex
new file mode 100644
index 0000000..fdb0050
--- /dev/null
+++ b/virtio-i2c.tex
@@ -0,0 +1,139 @@
+\section{I2C Adapter Device}\label{sec:Device Types / I2C Adapter Device}
+
+virtio-i2c is a virtual I2C adapter device.
</pre>
        </blockquote>
      </blockquote>
      <pre class=3D"moz-quote-pre" wrap=3D"">
BTW is this neessarily a virtual device? One can build a physical
one to this spec, no?
</pre>
    </blockquote>
    The virtio-i2c is a virtual I2C master device. One can attach a host
    physical<br>
    slave I2C device to this virtual device.<br>
    <blockquote type=3D"cite"
      cite=3D"mid:20201216144343-mutt-send-email-mst@kernel.org">
      <pre class=3D"moz-quote-pre" wrap=3D"">

</pre>
      <blockquote type=3D"cite">
        <pre class=3D"moz-quote-pre" wrap=3D"">It provides a way to flexibl=
y
</pre>
        <blockquote type=3D"cite">
          <pre class=3D"moz-quote-pre" wrap=3D"">+organize and use the host=
 I2C slave devices from the guest. By attaching
+the host ACPI I2C slave nodes to the virtual I2C adapter device, the guest=
 can
+communicate with them without changing or adding extra drivers for these
+slave I2C devices.=20
</pre>
        </blockquote>
        <pre class=3D"moz-quote-pre" wrap=3D"">
I know that the i2c spec talks about 'slave' devices, but can we find a
better terminology for the virtio standard? E.g. prefix this with

"Note: This standard uses the term 'controlled I2C device' to refer to
what the I2C standard calls 'slave I2C device'."

(Or whatever better term might exist.)

</pre>
        <blockquote type=3D"cite">
          <pre class=3D"moz-quote-pre" wrap=3D"">+
+\subsection{Device ID}\label{sec:Device Types / I2C Adapter Device / Devic=
e ID}
+34
+
+\subsection{Virtqueues}\label{sec:Device Types / I2C Adapter Device / Virt=
queues}
+
+\begin{description}
+\item[0] requestq
+\end{description}
+
+\subsection{Feature bits}\label{sec:Device Types / I2C Adapter Device / Fe=
ature bits}
+
+None currently defined.
+
+\subsection{Device configuration layout}\label{sec:Device Types / I2C Adap=
ter Device / Device configuration layout}
+
+None currently defined.
+
+\subsection{Device Initialization}\label{sec:Device Types / I2C Adapter De=
vice / Device Initialization}
+
+\begin{enumerate}
+\item The virtqueue is initialized.
+\end{enumerate}
+
+\subsection{Device Operation}\label{sec:Device Types / I2C Adapter Device =
/ Device Operation}
+
+\subsubsection{Device Operation: Request Queue}\label{sec:Device Types / I=
2C Adapter Device / Device Operation: Request Queue}
+
+The driver queues requests to the virtqueue, and they are used by the
+device. The request is the representation of segments of an I2C
+transaction. Each request is of form:
</pre>
        </blockquote>
      </blockquote>
      <pre class=3D"moz-quote-pre" wrap=3D"">
of the form
</pre>
    </blockquote>
    Will fix it.<br>
    <blockquote type=3D"cite"
      cite=3D"mid:20201216144343-mutt-send-email-mst@kernel.org">
      <pre class=3D"moz-quote-pre" wrap=3D"">
</pre>
      <blockquote type=3D"cite">
        <blockquote type=3D"cite">
          <pre class=3D"moz-quote-pre" wrap=3D"">+
+\begin{lstlisting}
+struct virtio_i2c_req {
+        le16 addr;
+        le32 flags;
+        le16 written;
+        le16 read;
+        u8 write_buf[];
+        u8 read_buf[];
+        u8 status;
+};
+\end{lstlisting}
+
+The \field{addr} of the request is the address of the I2C slave device.
+
+The \field{flags} of the request is currently reserved as zero for future
+feature extensibility.
+
+The \field{written} of the request is the number of data bytes in the \fie=
ld{write_buf}
+being written to the I2C slave address.
+
+The \field{read} of the request is the number of data bytes in the \field{=
read_buf}
+being read from the I2C slave address.
</pre>
        </blockquote>
      </blockquote>
      <pre class=3D"moz-quote-pre" wrap=3D"">
I note that read and written actually duplicate buf size
available in the descriptor.
Given we no longer mirror i2c_msg 1:1 do we still want to do this?
It will be trivial for the host device to populate these fields
correctly for linux.
Duplication of information iten leads to errors ...
</pre>
    </blockquote>
    Got it. I'm OK to remove read and written and use the size in the
    descriptor.<br>
    <blockquote type=3D"cite"
      cite=3D"mid:20201216144343-mutt-send-email-mst@kernel.org">
      <pre class=3D"moz-quote-pre" wrap=3D"">

</pre>
      <blockquote type=3D"cite">
        <blockquote type=3D"cite">
          <pre class=3D"moz-quote-pre" wrap=3D"">+
+The \field{write_buf} of the request contains one segment of an I2C transa=
ction
+being written to the device.
+
+The \field{read_buf} of the request contains one segment of an I2C transac=
tion
+being read from the device.
+
+The final \field{status} byte of the request is written by the device: eit=
her
+VIRTIO_I2C_MSG_OK for success or VIRTIO_I2C_MSG_ERR for error.
+
+\begin{lstlisting}
+#define VIRTIO_I2C_MSG_OK     0
+#define VIRTIO_I2C_MSG_ERR    1
+\end{lstlisting}
+
+If the \field{read}=3D0 and the \field{written}&gt;0, the request is calle=
d write request.
+
+If the \field{read}&gt;0 and the \field{written}=3D0, the request is calle=
d read request.
+
+If the \field{read}&gt;0 and the \field{written}&gt;0, the request is call=
ed write-read request.
+It means an I2C write segment followed by a read segment. Usually, the wri=
te segment
+provides the number of an I2C slave device register to be read.
+
+The \field{read}=3D0 and at the same time the \field{written}=3D0 doesn't =
make any sense.
+The driver SHOULD never send such request.
</pre>
        </blockquote>
        <pre class=3D"moz-quote-pre" wrap=3D"">
'SHOULD' makes this a normative statement.

</pre>
        <blockquote type=3D"cite">
          <pre class=3D"moz-quote-pre" wrap=3D"">+
+\subsubsection{Device Operation: Operation Status}\label{sec:Device Types =
/ I2C Adapter Device / Device Operation: Operation Status}
+
+A driver may send one request or multiple requests to the device at a time=
.
+The requests in the virtqueue MUST be queued and processed in order.
</pre>
        </blockquote>
        <pre class=3D"moz-quote-pre" wrap=3D"">
Same here, 'MUST' makes this a normative statement. I think lowercasing
these terms would make it correct.

</pre>
      </blockquote>
      <pre class=3D"moz-quote-pre" wrap=3D"">

It won't, the relevant rfc includes MUST and must etc.

If this is normative move it to a normative statement.
Or preferably, both change this to e.g.

The requests in the virtqueue are both queued and processed in order.

and add a normative statement in the normative section.

</pre>
    </blockquote>
    OK. Will fix it.<br>
    <blockquote type=3D"cite"
      cite=3D"mid:20201216144343-mutt-send-email-mst@kernel.org">
      <pre class=3D"moz-quote-pre" wrap=3D"">
</pre>
      <blockquote type=3D"cite">
        <blockquote type=3D"cite">
          <pre class=3D"moz-quote-pre" wrap=3D"">+
+If a driver sends multiple requests at a time and a device fails to proces=
s
+some of them, then the first failed request MUST have its \field{status}
+being set to VIRTIO_I2C_MSG_ERR by the device and the requests after the f=
irst
+failed one MUST also be treated as VIRTIO_I2C_MSG_ERR by the driver,
+no matter what \field{status} of them. In this case, the number of success=
fully
+sent requests this time is the number of the last request being successful=
ly
+processed.
+
+\drivernormative{\subsubsection}{Device Operation}{Device Types / I2C Adap=
ter Device / Device Operation}
+
+A driver MUST set \field{addr}, \field{flags}(currently reserved as zero),
</pre>
        </blockquote>
        <pre class=3D"moz-quote-pre" wrap=3D"">
I'd drop "(currently reserved as zero)" here and add

"A driver MUST set \field{flags} to zero."


</pre>
        <blockquote type=3D"cite">
          <pre class=3D"moz-quote-pre" wrap=3D"">+\field{written} and \fiel=
d{read} before sending the request.
+
+A driver MUST place one segment of an I2C transaction into \field{write_bu=
f} if the
</pre>
        </blockquote>
        <pre class=3D"moz-quote-pre" wrap=3D"">
s/if the/if/

</pre>
        <blockquote type=3D"cite">
          <pre class=3D"moz-quote-pre" wrap=3D"">+\field{written}&gt;0. =20
+
+A driver MUST NOT use \field{read_buf} if the final \field{status} returne=
d
+from the device is VIRTIO_I2C_MSG_ERR.
+
+A driver MAY queue one request or multiple requests at a time.
+
+A driver MUST queue the requests in order if multiple requests are going t=
o
+be sent at a time.
+
+If multiple requests are sent at a time and some of them returned from the
+device have the \field{status} being VIRTIO_I2C_MSG_ERR, a driver MUST tre=
at
+the first failed request and the requests after the first failed one as
+VIRTIO_I2C_MSG_ERR.
+
+\devicenormative{\subsubsection}{Device Operation}{Device Types / I2C Adap=
ter Device / Device Operation}
+
+A device SHOULD keep consistent behaviors with the hardware as described i=
n
+\hyperref[intro:I2C]{I2C}.
+
+A device MUST NOT change the value of \field{addr}, \field{flags}, \field{=
written},
+\field{read} and \field{write_buf}.
+
+A device MUST place one segment of an I2C transaction into \field{read_buf=
} if the
</pre>
        </blockquote>
        <pre class=3D"moz-quote-pre" wrap=3D"">
s/if/if the/

</pre>
        <blockquote type=3D"cite">
          <pre class=3D"moz-quote-pre" wrap=3D"">+\field{read}&gt;0. =20
+
+A device MUST guarantee the requests in the virtqueue being processed in o=
rder
+if multiple requests are received at a time.
+
+If multiple requests are received at a time and some of them being process=
ed failed,
</pre>
        </blockquote>
      </blockquote>
      <pre class=3D"moz-quote-pre" wrap=3D"">
and processing of some of the requests fails
</pre>
    </blockquote>
    Will fix it.<br>
    <blockquote type=3D"cite"
      cite=3D"mid:20201216144343-mutt-send-email-mst@kernel.org">
      <pre class=3D"moz-quote-pre" wrap=3D"">
</pre>
      <blockquote type=3D"cite">
        <blockquote type=3D"cite">
          <pre class=3D"moz-quote-pre" wrap=3D"">+a device MUST set the \fi=
eld{status} of the first failed request to be
+VIRTIO_I2C_MSG_ERR and MAY set the \field{status} of the requests after
+the first failed one to be VIRTIO_I2C_MSG_ERR.
</pre>
        </blockquote>
      </blockquote>
      <pre class=3D"moz-quote-pre" wrap=3D"">
So what is it saying? That VIRTIO_I2C_MSG_ERR can also mean
"previous request failed"?
</pre>
    </blockquote>
    <pre class=3D"moz-quote-pre" wrap=3D"">It means if for example 5 reques=
ts are sent and received with
req3 failed.Since the driver must <span class=3D"fontstyle0">treat the firs=
t failed request (req3)
and the requests after the first failed one (req4 and req5) as VIRTIO_I2C_M=
SG_ERR.</span>

So we don't need to care about the status of the req4 and req5 if req3 fail=
ed.They will
be treated as failed no matter what status.
=20
req1(OK)  req2(OK)  req3(FAIL)  req4  req5

</pre>
    <blockquote type=3D"cite"
      cite=3D"mid:20201216144343-mutt-send-email-mst@kernel.org">
      <pre class=3D"moz-quote-pre" wrap=3D"">
</pre>
    </blockquote>
  </body>
</html>

--------------CCB8D35CFD9FF0937FD31D3D--

