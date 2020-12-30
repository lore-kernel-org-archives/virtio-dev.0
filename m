Return-Path: virtio-comment-return-1612-cohuck=redhat.com@lists.oasis-open.org
Sender: <virtio-comment@lists.oasis-open.org>
List-Post: <mailto:virtio-comment@lists.oasis-open.org>
List-Help: <mailto:virtio-comment-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-comment-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-comment-subscribe@lists.oasis-open.org>
References: <ff3ec9f5cb7f480a52913790f698ad45c66edcc2.1608796685.git.jie.deng@intel.com>
 <20201229110934.GA55616@stefanha-x1.localdomain>
From: Jie Deng <jie.deng@intel.com>
Message-ID: <b6267b12-4026-ec9b-5bec-155246b1cc00@intel.com>
Date: Wed, 30 Dec 2020 10:17:23 +0800
MIME-Version: 1.0
In-Reply-To: <20201229110934.GA55616@stefanha-x1.localdomain>
Subject: Re: [virtio-comment] [PATCH v6] virtio-i2c: add the device
 specification
Content-Type: multipart/alternative;
 boundary="------------438B3D961E624EDB27CA5287"
Content-Language: en-US
To: Stefan Hajnoczi <stefanha@redhat.com>
Cc: virtio-comment@lists.oasis-open.org, virtio-dev@lists.oasis-open.org, mst@redhat.com, cohuck@redhat.com, pbonzini@redhat.com, kraxel@redhat.com, wsa+renesas@sang-engineering.com, andriy.shevchenko@linux.intel.com, conghui.chen@intel.com, yu1.wang@intel.com, shuo.a.liu@intel.com
List-ID: <virtio-dev.lists.oasis-open.org>

--------------438B3D961E624EDB27CA5287
Content-Type: text/plain; charset=WINDOWS-1252; format=flowed
Content-Transfer-Encoding: quoted-printable

On 2020/12/29 19:09, Stefan Hajnoczi wrote:

> On Thu, Dec 24, 2020 at 04:10:43PM +0800, Jie Deng wrote:
>> +\subsection{Device Operation}\label{sec:Device Types / I2C Adapter Devi=
ce / Device Operation}
>> +
>> +\subsubsection{Device Operation: Request Queue}\label{sec:Device Types =
/ I2C Adapter Device / Device Operation: Request Queue}
>> +
>> +The driver queues requests to the virtqueue, and they are used by the
>> +device. The request is the representation of segments of an I2C
>> +transaction. Each request is of the form:
>> +
>> +\begin{lstlisting}
>> +struct virtio_i2c_out_hdr {
>> +        le16 addr;
>> +        le16 padding;
>> +        le32 flags;
>> +};
>> +\end{lstlisting}
>> +
>> +\begin{lstlisting}
>> +struct virtio_i2c_in_hdr {
>> +        u8 status;
>> +};
>> +\end{lstlisting}
>> +
>> +\begin{lstlisting}
>> +struct virtio_i2c_req {
>> +        struct virtio_i2c_out_hdr out_hdr;
>> +        u8 write_buf[];
>> +        u8 read_buf[];
>> +        struct virtio_i2c_in_hdr in_hdr;
>> +};
>> +\end{lstlisting}
>> +
>> +The \field{addr} of the request is the address of the I2C controlled de=
vice.
>> +The format of \field{addr} is defined in paragraph 3.1.10 and 3.1.11 of
>> +\hyperref[intro:I2C]{I2C}.
> It's still unclear how addresses are represented in le16 addr even after
> reading the I2C paragraphs mentioned above.
>
> Here is my guess:
>
> le16 addr  15 14 13 12 11 10  9  8  7  6  5  4  3  2  1  0
> 7-bit       0  0  0  0  0  0  0  0  A6 A5 A4 A3 A2 A1 A0 0
> 10-bit     A7 A6 A5 A4 A3 A2 A1 A0   1  1  1  1  0 A9 A8 0
>
> The R/W bit is ignored and always set to 0 since the I/O direction is
> already implicit in the size of write_buf[] and read_buf[].
>
> Is this correct? Please document the exact layout in the virtio spec
> since the I2C spec does not describe an le16 representation.
Correct. But, I prefer to keep the definition exactly the same with the=20
I2C protocol.
Not to ignore the R/W bit in addr.

le16 addr  15 14 13 12 11 10  9  8  7  6  5  4  3  2  1  0
7-bit       0  0  0  0  0  0  0  0  A6 A5 A4 A3 A2 A1 A0*R/W*
10-bit     A7 A6 A5 A4 A3 A2 A1 A0   1  1  1  1  0 A9 A8*R/W*

The backend may check the R/W bit in addr to make sure it is compatible
with that in the descriptor. If not, then it is an error request.

>> +
>> +The \field{padding} is used to pad to full dword.
>> +
>> +The \field{flags} of the request is currently reserved as zero for futu=
re
>> +feature extensibility.
>> +
>> +The \field{write_buf} of the request contains one segment of an I2C tra=
nsaction
>> +being written to the device.
>> +
>> +The \field{read_buf} of the request contains one segment of an I2C tran=
saction
>> +being read from the device.
>> +
>> +The final \field{status} byte of the request is written by the device: =
either
>> +VIRTIO_I2C_MSG_OK for success or VIRTIO_I2C_MSG_ERR for error.
>> +
>> +\begin{lstlisting}
>> +#define VIRTIO_I2C_MSG_OK     0
>> +#define VIRTIO_I2C_MSG_ERR    1
>> +\end{lstlisting}
>> +
>> +If ``length of \field{read_buf}''=3D0 and ``length of \field{write_buf}=
''>0,
>> +the request is called write request.
>> +
>> +If ``length of \field{read_buf}''>0 and ``length of \field{write_buf}''=
=3D0,
>> +the request is called read request.
>> +
>> +If ``length of \field{read_buf}''>0 and ``length of \field{write_buf}''=
>0,
>> +the request is called write-read request. It means an I2C write segment=
 followed
>> +by a read segment. Usually, the write segment provides the number of an=
 I2C
>> +controlled device register to be read.
>> +
>> +The case when ``length of \field{write_buf}''=3D0, and at the same time=
,
>> +``length of \field{read_buf}''=3D0 doesn't make any sense.
>> +
>> +\subsubsection{Device Operation: Operation Status}\label{sec:Device Typ=
es / I2C Adapter Device / Device Operation: Operation Status}
>> +
>> +\field{addr}, ``length of \field{write_buf}'' and ``length of \field{re=
ad_buf}''
>> +are determined by the driver, while \field{status} is determined by the=
 processing
>> +of the devcie. A driver puts the data written to the device into \field=
{write_buf}, while
> s/devcie/device/
Will fix this typo.
>
>> +a device puts the data of the corresponding length into \field{read_buf=
} according the
>> +request of the driver.
>> +
>> +A driver may send one request or multiple requests to the device at a t=
ime.
>> +The requests in the virtqueue are both queued and processed in order.
>> +
>> +If a driver sends multiple requests at a time and a device fails to pro=
cess
>> +some of them, then the first failed request will have its \field{status=
}
>> +being set to VIRTIO_I2C_MSG_ERR by the device and the requests after th=
e first
>> +failed one will also be treated as VIRTIO_I2C_MSG_ERR by the driver,
>> +no matter what \field{status} of them. In this case, the number of succ=
essfully
>> +sent requests this time is the number of the last request being success=
fully
>> +processed.
> If I understand correctly all requests submitted in a single available
> buffer notification are grouped together. Once the first request fails
> the driver must treat all remaining requests as failed?
Right. That's how it works.
> Devices may poll vrings instead of using available buffer notifications.
> Polled devices cannot provide the grouping semantics described above.
Poll is not recommended for this device. But if poll is used, the device=20
must notify
the driver once it encounters an error request.

So if poll is used and the virtqueue has following requests (May be=20
submitted by many kick operation, no need to group)

Y Y Y Y N X X X X

(Y: OK,=A0=A0 N: error,=A0=A0 X: no need to care about, must be treated as =
error.)

The device must notify=A0 the driver at the first "N" and driver must=20
treat the N and "X X X X" as error.

>
> If you want to group requests then it is necessary to include a
> per-request group ID or continuation/end-of-group field. virtio-net
> VIRTIO_NET_F_MRG_RXBUF is an example of this.
>
> Additionally, this paragraph does not specify whether the device
> executes the remaining requests or not. This seems problematic to me
> because the driver does not know which requests actually executed when
> a request in a group of requests fails?
The device must not execute the remaining requests.
>
>> +
>> +\drivernormative{\subsubsection}{Device Operation}{Device Types / I2C A=
dapter Device / Device Operation}
>> +
>> +A driver MUST set \field{addr} and \field{flags} before sending the req=
uest.
>> +
>> +A driver MUST set \field{flags} to be zero.
>> +
>> +The driver SHOULD never send a request with ``length of \field{write_bu=
f}''=3D0 and
>> +``length of \field{read_buf}''=3D0 at the same time.
> s/SHOULD never/MUST NOT/?
Will fix it.
>
>> +
>> +A driver MUST NOT use \field{read_buf} if the final \field{status} retu=
rned
>> +from the device is VIRTIO_I2C_MSG_ERR.
>> +
>> +A driver MAY queue one request or multiple requests at a time.
> I think no other VIRTIO device only allows one request queued at a time.
> Therefore it's probably not necessary to include this statement - all
> devices allow one or more requests to be queued at a time.

Will remove it.


--------------438B3D961E624EDB27CA5287
Content-Type: text/html; charset=windows-1252
Content-Transfer-Encoding: quoted-printable

<html>
  <head>
    <meta http-equiv=3D"Content-Type" content=3D"text/html;
      charset=3Dwindows-1252">
  </head>
  <body>
    <p>On 2020/12/29 19:09, Stefan Hajnoczi wrote:<br>
    </p>
    <blockquote type=3D"cite"
      cite=3D"mid:20201229110934.GA55616@stefanha-x1.localdomain">
      <pre class=3D"moz-quote-pre" wrap=3D"">On Thu, Dec 24, 2020 at 04:10:=
43PM +0800, Jie Deng wrote:
</pre>
      <blockquote type=3D"cite">
        <pre class=3D"moz-quote-pre" wrap=3D"">+\subsection{Device Operatio=
n}\label{sec:Device Types / I2C Adapter Device / Device Operation}
+
+\subsubsection{Device Operation: Request Queue}\label{sec:Device Types / I=
2C Adapter Device / Device Operation: Request Queue}
+
+The driver queues requests to the virtqueue, and they are used by the
+device. The request is the representation of segments of an I2C
+transaction. Each request is of the form:
+
+\begin{lstlisting}
+struct virtio_i2c_out_hdr {
+        le16 addr;
+        le16 padding;
+        le32 flags;
+};
+\end{lstlisting}
+
+\begin{lstlisting}
+struct virtio_i2c_in_hdr {
+        u8 status;
+};
+\end{lstlisting}
+
+\begin{lstlisting}
+struct virtio_i2c_req {
+        struct virtio_i2c_out_hdr out_hdr;
+        u8 write_buf[];
+        u8 read_buf[];
+        struct virtio_i2c_in_hdr in_hdr;
+};
+\end{lstlisting}
+
+The \field{addr} of the request is the address of the I2C controlled devic=
e.
+The format of \field{addr} is defined in paragraph 3.1.10 and 3.1.11 of
+\hyperref[intro:I2C]{I2C}.
</pre>
      </blockquote>
      <pre class=3D"moz-quote-pre" wrap=3D"">
It's still unclear how addresses are represented in le16 addr even after
reading the I2C paragraphs mentioned above.

Here is my guess:

le16 addr  15 14 13 12 11 10  9  8  7  6  5  4  3  2  1  0
7-bit       0  0  0  0  0  0  0  0  A6 A5 A4 A3 A2 A1 A0 0
10-bit     A7 A6 A5 A4 A3 A2 A1 A0   1  1  1  1  0 A9 A8 0

The R/W bit is ignored and always set to 0 since the I/O direction is
already implicit in the size of write_buf[] and read_buf[].

Is this correct? Please document the exact layout in the virtio spec
since the I2C spec does not describe an le16 representation.
</pre>
    </blockquote>
    Correct. But, I prefer to keep the definition exactly the same with
    the I2C protocol.<br>
    Not to ignore the R/W bit in addr.<br>
    <pre class=3D"moz-quote-pre" wrap=3D"">le16 addr  15 14 13 12 11 10  9 =
 8  7  6  5  4  3  2  1  0
7-bit       0  0  0  0  0  0  0  0  A6 A5 A4 A3 A2 A1 A0 <b>R/W</b>
10-bit     A7 A6 A5 A4 A3 A2 A1 A0   1  1  1  1  0 A9 A8 <b>R/W</b>

The backend may check the R/W bit in addr to make sure it is compatible
with that in the descriptor. If not, then it is an error request.
</pre>
    <blockquote type=3D"cite"
      cite=3D"mid:20201229110934.GA55616@stefanha-x1.localdomain">
      <pre class=3D"moz-quote-pre" wrap=3D"">
</pre>
      <blockquote type=3D"cite">
        <pre class=3D"moz-quote-pre" wrap=3D"">+
+The \field{padding} is used to pad to full dword.
+
+The \field{flags} of the request is currently reserved as zero for future
+feature extensibility.
+
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
+If ``length of \field{read_buf}''=3D0 and ``length of \field{write_buf}''&=
gt;0,
+the request is called write request.
+
+If ``length of \field{read_buf}''&gt;0 and ``length of \field{write_buf}''=
=3D0,
+the request is called read request.
+
+If ``length of \field{read_buf}''&gt;0 and ``length of \field{write_buf}''=
&gt;0,
+the request is called write-read request. It means an I2C write segment fo=
llowed
+by a read segment. Usually, the write segment provides the number of an I2=
C
+controlled device register to be read.
+
+The case when ``length of \field{write_buf}''=3D0, and at the same time,
+``length of \field{read_buf}''=3D0 doesn't make any sense.
+
+\subsubsection{Device Operation: Operation Status}\label{sec:Device Types =
/ I2C Adapter Device / Device Operation: Operation Status}
+
+\field{addr}, ``length of \field{write_buf}'' and ``length of \field{read_=
buf}''
+are determined by the driver, while \field{status} is determined by the pr=
ocessing
+of the devcie. A driver puts the data written to the device into \field{wr=
ite_buf}, while
</pre>
      </blockquote>
      <pre class=3D"moz-quote-pre" wrap=3D"">
s/devcie/device/</pre>
    </blockquote>
    Will fix this typo.<br>
    <blockquote type=3D"cite"
      cite=3D"mid:20201229110934.GA55616@stefanha-x1.localdomain">
      <pre class=3D"moz-quote-pre" wrap=3D"">

</pre>
      <blockquote type=3D"cite">
        <pre class=3D"moz-quote-pre" wrap=3D"">+a device puts the data of t=
he corresponding length into \field{read_buf} according the
+request of the driver.
+
+A driver may send one request or multiple requests to the device at a time=
.
+The requests in the virtqueue are both queued and processed in order.
+
+If a driver sends multiple requests at a time and a device fails to proces=
s
+some of them, then the first failed request will have its \field{status}
+being set to VIRTIO_I2C_MSG_ERR by the device and the requests after the f=
irst
+failed one will also be treated as VIRTIO_I2C_MSG_ERR by the driver,
+no matter what \field{status} of them. In this case, the number of success=
fully
+sent requests this time is the number of the last request being successful=
ly
+processed.
</pre>
      </blockquote>
      <pre class=3D"moz-quote-pre" wrap=3D"">
If I understand correctly all requests submitted in a single available
buffer notification are grouped together. Once the first request fails
the driver must treat all remaining requests as failed?
</pre>
    </blockquote>
    Right. That's how it works.<br>
    <blockquote type=3D"cite"
      cite=3D"mid:20201229110934.GA55616@stefanha-x1.localdomain">
      <pre class=3D"moz-quote-pre" wrap=3D"">
Devices may poll vrings instead of using available buffer notifications.
Polled devices cannot provide the grouping semantics described above.</pre>
    </blockquote>
    Poll is not recommended for this device. But if poll is used, the
    device must notify<br>
    the driver once it encounters an error request.
    <p>So if poll is used and the virtqueue has following requests (May
      be submitted by many kick operation, no need to group)<br>
    </p>
    Y Y Y Y N X X X X<br>
    <p>(Y: OK,=A0=A0 N: error,=A0=A0 X: no need to care about, must be trea=
ted
      as error.)</p>
    <p>The device must notify=A0 the driver at the first "N" and driver
      must treat the N and "X X X X" as error.<br>
    </p>
    <blockquote type=3D"cite"
      cite=3D"mid:20201229110934.GA55616@stefanha-x1.localdomain">
      <pre class=3D"moz-quote-pre" wrap=3D"">

If you want to group requests then it is necessary to include a
per-request group ID or continuation/end-of-group field. virtio-net
VIRTIO_NET_F_MRG_RXBUF is an example of this.

Additionally, this paragraph does not specify whether the device
executes the remaining requests or not. This seems problematic to me
because the driver does not know which requests actually executed when
a request in a group of requests fails?</pre>
    </blockquote>
    The device must not execute the remaining requests.=A0 <br>
    <blockquote type=3D"cite"
      cite=3D"mid:20201229110934.GA55616@stefanha-x1.localdomain">
      <pre class=3D"moz-quote-pre" wrap=3D"">

</pre>
      <blockquote type=3D"cite">
        <pre class=3D"moz-quote-pre" wrap=3D"">+
+\drivernormative{\subsubsection}{Device Operation}{Device Types / I2C Adap=
ter Device / Device Operation}
+
+A driver MUST set \field{addr} and \field{flags} before sending the reques=
t.
+
+A driver MUST set \field{flags} to be zero.
+
+The driver SHOULD never send a request with ``length of \field{write_buf}'=
'=3D0 and
+``length of \field{read_buf}''=3D0 at the same time.
</pre>
      </blockquote>
      <pre class=3D"moz-quote-pre" wrap=3D"">
s/SHOULD never/MUST NOT/?</pre>
    </blockquote>
    Will fix it.<br>
    <blockquote type=3D"cite"
      cite=3D"mid:20201229110934.GA55616@stefanha-x1.localdomain">
      <pre class=3D"moz-quote-pre" wrap=3D"">

</pre>
      <blockquote type=3D"cite">
        <pre class=3D"moz-quote-pre" wrap=3D"">+
+A driver MUST NOT use \field{read_buf} if the final \field{status} returne=
d
+from the device is VIRTIO_I2C_MSG_ERR.
+
+A driver MAY queue one request or multiple requests at a time.
</pre>
      </blockquote>
      <pre class=3D"moz-quote-pre" wrap=3D"">
I think no other VIRTIO device only allows one request queued at a time.
Therefore it's probably not necessary to include this statement - all
devices allow one or more requests to be queued at a time.</pre>
    </blockquote>
    <p>Will remove it.<br>
    </p>
    <blockquote type=3D"cite"
      cite=3D"mid:20201229110934.GA55616@stefanha-x1.localdomain">
      <pre class=3D"moz-quote-pre" wrap=3D"">
</pre>
    </blockquote>
  </body>
</html>

--------------438B3D961E624EDB27CA5287--

