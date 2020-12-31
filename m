Return-Path: virtio-comment-return-1616-cohuck=redhat.com@lists.oasis-open.org
Sender: <virtio-comment@lists.oasis-open.org>
List-Post: <mailto:virtio-comment@lists.oasis-open.org>
List-Help: <mailto:virtio-comment-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-comment-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-comment-subscribe@lists.oasis-open.org>
References: <ff3ec9f5cb7f480a52913790f698ad45c66edcc2.1608796685.git.jie.deng@intel.com>
 <20201229110934.GA55616@stefanha-x1.localdomain>
 <b6267b12-4026-ec9b-5bec-155246b1cc00@intel.com>
 <20201230102037.GA87700@stefanha-x1.localdomain>
From: Jie Deng <jie.deng@intel.com>
Message-ID: <e5b8e645-083f-638a-69cc-f1b01c7a4dd0@intel.com>
Date: Thu, 31 Dec 2020 10:50:13 +0800
MIME-Version: 1.0
In-Reply-To: <20201230102037.GA87700@stefanha-x1.localdomain>
Subject: Re: [virtio-comment] [PATCH v6] virtio-i2c: add the device
 specification
Content-Type: multipart/alternative;
 boundary="------------A01D55F00F0900455919B6A7"
Content-Language: en-US
To: Stefan Hajnoczi <stefanha@redhat.com>
Cc: virtio-comment@lists.oasis-open.org, virtio-dev@lists.oasis-open.org, mst@redhat.com, cohuck@redhat.com, pbonzini@redhat.com, kraxel@redhat.com, wsa+renesas@sang-engineering.com, andriy.shevchenko@linux.intel.com, conghui.chen@intel.com, yu1.wang@intel.com, shuo.a.liu@intel.com
List-ID: <virtio-dev.lists.oasis-open.org>

--------------A01D55F00F0900455919B6A7
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable


On 2020/12/30 18:20, Stefan Hajnoczi wrote:
> On Wed, Dec 30, 2020 at 10:17:23AM +0800, Jie Deng wrote:
>> On 2020/12/29 19:09, Stefan Hajnoczi wrote:
>>
>>> On Thu, Dec 24, 2020 at 04:10:43PM +0800, Jie Deng wrote:
>>>> +\subsection{Device Operation}\label{sec:Device Types / I2C Adapter De=
vice / Device Operation}
>>>> +
>>>> +\subsubsection{Device Operation: Request Queue}\label{sec:Device Type=
s / I2C Adapter Device / Device Operation: Request Queue}
>>>> +
>>>> +The driver queues requests to the virtqueue, and they are used by the
>>>> +device. The request is the representation of segments of an I2C
>>>> +transaction. Each request is of the form:
>>>> +
>>>> +\begin{lstlisting}
>>>> +struct virtio_i2c_out_hdr {
>>>> +        le16 addr;
>>>> +        le16 padding;
>>>> +        le32 flags;
>>>> +};
>>>> +\end{lstlisting}
>>>> +
>>>> +\begin{lstlisting}
>>>> +struct virtio_i2c_in_hdr {
>>>> +        u8 status;
>>>> +};
>>>> +\end{lstlisting}
>>>> +
>>>> +\begin{lstlisting}
>>>> +struct virtio_i2c_req {
>>>> +        struct virtio_i2c_out_hdr out_hdr;
>>>> +        u8 write_buf[];
>>>> +        u8 read_buf[];
>>>> +        struct virtio_i2c_in_hdr in_hdr;
>>>> +};
>>>> +\end{lstlisting}
>>>> +
>>>> +The \field{addr} of the request is the address of the I2C controlled =
device.
>>>> +The format of \field{addr} is defined in paragraph 3.1.10 and 3.1.11 =
of
>>>> +\hyperref[intro:I2C]{I2C}.
>>> It's still unclear how addresses are represented in le16 addr even afte=
r
>>> reading the I2C paragraphs mentioned above.
>>>
>>> Here is my guess:
>>>
>>> le16 addr  15 14 13 12 11 10  9  8  7  6  5  4  3  2  1  0
>>> 7-bit       0  0  0  0  0  0  0  0  A6 A5 A4 A3 A2 A1 A0 0
>>> 10-bit     A7 A6 A5 A4 A3 A2 A1 A0   1  1  1  1  0 A9 A8 0
>>>
>>> The R/W bit is ignored and always set to 0 since the I/O direction is
>>> already implicit in the size of write_buf[] and read_buf[].
>>>
>>> Is this correct? Please document the exact layout in the virtio spec
>>> since the I2C spec does not describe an le16 representation.
>> Correct. But, I prefer to keep the definition exactly the same with the =
I2C
>> protocol.
>> Not to ignore the R/W bit in addr.
>>
>> le16 addr  15 14 13 12 11 10  9  8  7  6  5  4  3  2  1  0
>> 7-bit       0  0  0  0  0  0  0  0  A6 A5 A4 A3 A2 A1 A0*R/W*
>> 10-bit     A7 A6 A5 A4 A3 A2 A1 A0   1  1  1  1  0 A9 A8*R/W*
>>
>> The backend may check the R/W bit in addr to make sure it is compatible
>> with that in the descriptor. If not, then it is an error request.
> The R/W bit is unable to describe bi-directional requests where
> read_buf[] and write_buf[] are both non-zero.
>
> The device also needs to check the sizeof(read_buf) =3D=3D 0 and
> sizeof(write_buf) =3D=3D 0 case separately (it's not handled by the R/W
> bit).
>
> I don't think the R/W bit adds much, except maybe adding a sanity check
> for read-only and write-only requests. Given that it adds complexity and
> some device implementations may forget to validate it, I suggest
> dropping it.
OK. Let's ignore the R/W bit.
>>>> +
>>>> +The \field{padding} is used to pad to full dword.
>>>> +
>>>> +The \field{flags} of the request is currently reserved as zero for fu=
ture
>>>> +feature extensibility.
>>>> +
>>>> +The \field{write_buf} of the request contains one segment of an I2C t=
ransaction
>>>> +being written to the device.
>>>> +
>>>> +The \field{read_buf} of the request contains one segment of an I2C tr=
ansaction
>>>> +being read from the device.
>>>> +
>>>> +The final \field{status} byte of the request is written by the device=
: either
>>>> +VIRTIO_I2C_MSG_OK for success or VIRTIO_I2C_MSG_ERR for error.
>>>> +
>>>> +\begin{lstlisting}
>>>> +#define VIRTIO_I2C_MSG_OK     0
>>>> +#define VIRTIO_I2C_MSG_ERR    1
>>>> +\end{lstlisting}
>>>> +
>>>> +If ``length of \field{read_buf}''=3D0 and ``length of \field{write_bu=
f}''>0,
>>>> +the request is called write request.
>>>> +
>>>> +If ``length of \field{read_buf}''>0 and ``length of \field{write_buf}=
''=3D0,
>>>> +the request is called read request.
>>>> +
>>>> +If ``length of \field{read_buf}''>0 and ``length of \field{write_buf}=
''>0,
>>>> +the request is called write-read request. It means an I2C write segme=
nt followed
>>>> +by a read segment. Usually, the write segment provides the number of =
an I2C
>>>> +controlled device register to be read.
>>>> +
>>>> +The case when ``length of \field{write_buf}''=3D0, and at the same ti=
me,
>>>> +``length of \field{read_buf}''=3D0 doesn't make any sense.
>>>> +
>>>> +\subsubsection{Device Operation: Operation Status}\label{sec:Device T=
ypes / I2C Adapter Device / Device Operation: Operation Status}
>>>> +
>>>> +\field{addr}, ``length of \field{write_buf}'' and ``length of \field{=
read_buf}''
>>>> +are determined by the driver, while \field{status} is determined by t=
he processing
>>>> +of the devcie. A driver puts the data written to the device into \fie=
ld{write_buf}, while
>>> s/devcie/device/
>> Will fix this typo.
>>>> +a device puts the data of the corresponding length into \field{read_b=
uf} according the
>>>> +request of the driver.
>>>> +
>>>> +A driver may send one request or multiple requests to the device at a=
 time.
>>>> +The requests in the virtqueue are both queued and processed in order.
>>>> +
>>>> +If a driver sends multiple requests at a time and a device fails to p=
rocess
>>>> +some of them, then the first failed request will have its \field{stat=
us}
>>>> +being set to VIRTIO_I2C_MSG_ERR by the device and the requests after =
the first
>>>> +failed one will also be treated as VIRTIO_I2C_MSG_ERR by the driver,
>>>> +no matter what \field{status} of them. In this case, the number of su=
ccessfully
>>>> +sent requests this time is the number of the last request being succe=
ssfully
>>>> +processed.
>>> If I understand correctly all requests submitted in a single available
>>> buffer notification are grouped together. Once the first request fails
>>> the driver must treat all remaining requests as failed?
>> Right. That's how it works.
>>> Devices may poll vrings instead of using available buffer notifications=
.
>>> Polled devices cannot provide the grouping semantics described above.
>> Poll is not recommended for this device. But if poll is used, the device
>> must notify
>> the driver once it encounters an error request.
>>
>> So if poll is used and the virtqueue has following requests (May be
>> submitted by many kick operation, no need to group)
>>
>> Y Y Y Y N X X X X
>>
>> (Y: OK,=C2=A0=C2=A0 N: error,=C2=A0=C2=A0 X: no need to care about, must=
 be treated as error.)
>>
>> The device must notify=C2=A0 the driver at the first "N" and driver must=
 treat
>> the N and "X X X X" as error.
>>
>>> If you want to group requests then it is necessary to include a
>>> per-request group ID or continuation/end-of-group field. virtio-net
>>> VIRTIO_NET_F_MRG_RXBUF is an example of this.
>>>
>>> Additionally, this paragraph does not specify whether the device
>>> executes the remaining requests or not. This seems problematic to me
>>> because the driver does not know which requests actually executed when
>>> a request in a group of requests fails?
>> The device must not execute the remaining requests.
> Please add that to the spec so it's clear the device must fail remaining
> requests insteads of attempting to execute them.
Sure. Will do that.
> This approach causes a bottleneck when there are multiple I2C devices.
> It requires exclusive access to the virtqueue and virtual I2C bus,
> slowing down applications that are accessing separate I2C devices.
>
> This is inefficient, especially if the I2C devices are emulated or on
> separate physical I2C busses where request concurrent processing is
> possible.
>
> This also creates starvation/denial-of-service problems in the driver
> because an application can submit many requests and needs exclusive
> access to the virtqueue until all requests have completed.
>
> I suggest defining a VIRTIO_I2C_FLAGS_CONTINUATION bit in struct
> virtio_i2c_out_hdr::flags. When a request fails and this flag is set
> then the device fails all later requests until it reaches a request
> where the flag is zero. This allows the driver to enqueue a sequence of
> requests that fail as a group without waiting for an empty virtqueue.
The flags is designed to be a "driver->device" field for extensibility.=20
It is read-only=EF=BF=BD to the device.
So when a request fails, the device can't set this read-only field.

But we already have the virtio_i2c_in_hdr::status for this purpose. When=20
a request fails,
the status is then set by the device and the device fails all later=20
requests currently in the
virtqueue.

We just need to make sure that once the driver adds some requests to the=20
virtqueue,
it should complete them (either success or fail) before adding new=20
requests. I think this
is a behavior of physical I2C adapter drivers and we can follow.


--------------A01D55F00F0900455919B6A7
Content-Type: text/html; charset=windows-1252
Content-Transfer-Encoding: quoted-printable

<html>
  <head>
    <meta http-equiv=3D"Content-Type" content=3D"text/html;
      charset=3Dwindows-1252">
  </head>
  <body>
    <p><br>
    </p>
    <div class=3D"moz-cite-prefix">On 2020/12/30 18:20, Stefan Hajnoczi
      wrote:<br>
    </div>
    <blockquote type=3D"cite"
      cite=3D"mid:20201230102037.GA87700@stefanha-x1.localdomain">
      <pre class=3D"moz-quote-pre" wrap=3D"">On Wed, Dec 30, 2020 at 10:17:=
23AM +0800, Jie Deng wrote:
</pre>
      <blockquote type=3D"cite">
        <pre class=3D"moz-quote-pre" wrap=3D"">On 2020/12/29 19:09, Stefan =
Hajnoczi wrote:

</pre>
        <blockquote type=3D"cite">
          <pre class=3D"moz-quote-pre" wrap=3D"">On Thu, Dec 24, 2020 at 04=
:10:43PM +0800, Jie Deng wrote:
</pre>
          <blockquote type=3D"cite">
            <pre class=3D"moz-quote-pre" wrap=3D"">+\subsection{Device Oper=
ation}\label{sec:Device Types / I2C Adapter Device / Device Operation}
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
          <pre class=3D"moz-quote-pre" wrap=3D"">It's still unclear how add=
resses are represented in le16 addr even after
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
        <pre class=3D"moz-quote-pre" wrap=3D"">Correct. But, I prefer to ke=
ep the definition exactly the same with the I2C
protocol.
Not to ignore the R/W bit in addr.

le16 addr  15 14 13 12 11 10  9  8  7  6  5  4  3  2  1  0
7-bit       0  0  0  0  0  0  0  0  A6 A5 A4 A3 A2 A1 A0*R/W*
10-bit     A7 A6 A5 A4 A3 A2 A1 A0   1  1  1  1  0 A9 A8*R/W*

The backend may check the R/W bit in addr to make sure it is compatible
with that in the descriptor. If not, then it is an error request.
</pre>
      </blockquote>
      <pre class=3D"moz-quote-pre" wrap=3D"">
The R/W bit is unable to describe bi-directional requests where
read_buf[] and write_buf[] are both non-zero.

The device also needs to check the sizeof(read_buf) =3D=3D 0 and
sizeof(write_buf) =3D=3D 0 case separately (it's not handled by the R/W
bit).

I don't think the R/W bit adds much, except maybe adding a sanity check
for read-only and write-only requests. Given that it adds complexity and
some device implementations may forget to validate it, I suggest
dropping it.
</pre>
    </blockquote>
    OK. Let's ignore the R/W bit.<br>
    <blockquote type=3D"cite"
      cite=3D"mid:20201230102037.GA87700@stefanha-x1.localdomain">
      <pre class=3D"moz-quote-pre" wrap=3D"">
</pre>
      <blockquote type=3D"cite">
        <blockquote type=3D"cite">
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
          <pre class=3D"moz-quote-pre" wrap=3D"">s/devcie/device/
</pre>
        </blockquote>
        <pre class=3D"moz-quote-pre" wrap=3D"">Will fix this typo.
</pre>
        <blockquote type=3D"cite">
          <pre class=3D"moz-quote-pre" wrap=3D"">
</pre>
          <blockquote type=3D"cite">
            <pre class=3D"moz-quote-pre" wrap=3D"">+a device puts the data =
of the corresponding length into \field{read_buf} according the
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
          <pre class=3D"moz-quote-pre" wrap=3D"">If I understand correctly =
all requests submitted in a single available
buffer notification are grouped together. Once the first request fails
the driver must treat all remaining requests as failed?
</pre>
        </blockquote>
        <pre class=3D"moz-quote-pre" wrap=3D"">Right. That's how it works.
</pre>
        <blockquote type=3D"cite">
          <pre class=3D"moz-quote-pre" wrap=3D"">Devices may poll vrings in=
stead of using available buffer notifications.
Polled devices cannot provide the grouping semantics described above.
</pre>
        </blockquote>
        <pre class=3D"moz-quote-pre" wrap=3D"">Poll is not recommended for =
this device. But if poll is used, the device
must notify
the driver once it encounters an error request.

So if poll is used and the virtqueue has following requests (May be
submitted by many kick operation, no need to group)

Y Y Y Y N X X X X

(Y: OK,=C2=A0=C2=A0 N: error,=C2=A0=C2=A0 X: no need to care about, must be=
 treated as error.)

The device must notify=C2=A0 the driver at the first "N" and driver must tr=
eat
the N and "X X X X" as error.

</pre>
        <blockquote type=3D"cite">
          <pre class=3D"moz-quote-pre" wrap=3D"">
If you want to group requests then it is necessary to include a
per-request group ID or continuation/end-of-group field. virtio-net
VIRTIO_NET_F_MRG_RXBUF is an example of this.

Additionally, this paragraph does not specify whether the device
executes the remaining requests or not. This seems problematic to me
because the driver does not know which requests actually executed when
a request in a group of requests fails?
</pre>
        </blockquote>
        <pre class=3D"moz-quote-pre" wrap=3D"">The device must not execute =
the remaining requests.
</pre>
      </blockquote>
      <pre class=3D"moz-quote-pre" wrap=3D"">
Please add that to the spec so it's clear the device must fail remaining
requests insteads of attempting to execute them.
</pre>
    </blockquote>
    Sure. Will do that.<br>
    <blockquote type=3D"cite"
      cite=3D"mid:20201230102037.GA87700@stefanha-x1.localdomain">
      <pre class=3D"moz-quote-pre" wrap=3D"">
This approach causes a bottleneck when there are multiple I2C devices.
It requires exclusive access to the virtqueue and virtual I2C bus,
slowing down applications that are accessing separate I2C devices.

This is inefficient, especially if the I2C devices are emulated or on
separate physical I2C busses where request concurrent processing is
possible.

This also creates starvation/denial-of-service problems in the driver
because an application can submit many requests and needs exclusive
access to the virtqueue until all requests have completed.

I suggest defining a VIRTIO_I2C_FLAGS_CONTINUATION bit in struct
virtio_i2c_out_hdr::flags. When a request fails and this flag is set
then the device fails all later requests until it reaches a request
where the flag is zero. This allows the driver to enqueue a sequence of
requests that fail as a group without waiting for an empty virtqueue.</pre>
    </blockquote>
    The flags is designed to be a "driver-&gt;device" field for <span
      class=3D"fontstyle0">extensibility</span><span class=3D"fontstyle0"><=
/span><span
      class=3D"fontstyle0">. It is read-only=A0 to the device.</span><br>
    <span class=3D"fontstyle0">So </span>when a request fails, the device
    can't set this read-only field.<br>
    <p><span class=3D"fontstyle0"></span></p>
    <span class=3D"fontstyle0">But we already have the
      virtio_i2c_in_hdr::status for this purpose. When a request fails,</sp=
an><br>
    <span class=3D"fontstyle0">the status is then set by the device and </s=
pan>the
    device fails all later requests currently in the<br>
    virtqueue.<br>
    <br>
    We just need to make sure that once the driver adds some requests to
    the virtqueue,<br>
    it should complete them (either success or fail) before adding new
    requests. I think this<br>
    is a behavior of physical I2C adapter drivers and we can follow.<br>
    <p><span class=3D"fontstyle0"></span></p>
    <blockquote type=3D"cite"
      cite=3D"mid:20201230102037.GA87700@stefanha-x1.localdomain">
      <pre class=3D"moz-quote-pre" wrap=3D"">
</pre>
    </blockquote>
  </body>
</html>

--------------A01D55F00F0900455919B6A7--

