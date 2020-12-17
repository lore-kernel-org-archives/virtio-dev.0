Return-Path: virtio-comment-return-1557-cohuck=redhat.com@lists.oasis-open.org
Sender: <virtio-comment@lists.oasis-open.org>
List-Post: <mailto:virtio-comment@lists.oasis-open.org>
List-Help: <mailto:virtio-comment-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-comment-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-comment-subscribe@lists.oasis-open.org>
References: <1ea117ebe46d105eda21544acf85a5c7dbe2d8ec.1606283457.git.jie.deng@intel.com>
 <20201216155218.GA720702@stefanha-x1.localdomain>
From: Jie Deng <jie.deng@intel.com>
Message-ID: <b59c78ee-1f25-e32b-fc22-697b92084ae0@intel.com>
Date: Thu, 17 Dec 2020 15:08:07 +0800
MIME-Version: 1.0
In-Reply-To: <20201216155218.GA720702@stefanha-x1.localdomain>
Subject: Re: [virtio-comment] [PATCH v5] virtio-i2c: add the device
 specification
Content-Type: multipart/alternative;
 boundary="------------7FFBBD4BADE774911DA56493"
Content-Language: en-US
To: Stefan Hajnoczi <stefanha@redhat.com>
Cc: virtio-comment@lists.oasis-open.org, virtio-dev@lists.oasis-open.org, mst@redhat.com, cohuck@redhat.com, pbonzini@redhat.com, kraxel@redhat.com, wsa+renesas@sang-engineering.com, andriy.shevchenko@linux.intel.com, conghui.chen@intel.com, yu1.wang@intel.com, shuo.a.liu@intel.com
List-ID: <virtio-dev.lists.oasis-open.org>

--------------7FFBBD4BADE774911DA56493
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit


On 2020/12/16 23:52, Stefan Hajnoczi wrote:
> On Wed, Nov 25, 2020 at 01:55:18PM +0800, Jie Deng wrote:
>> diff --git a/virtio-i2c.tex b/virtio-i2c.tex
>> new file mode 100644
>> index 0000000..fdb0050
>> --- /dev/null
>> +++ b/virtio-i2c.tex
>> @@ -0,0 +1,139 @@
>> +\section{I2C Adapter Device}\label{sec:Device Types / I2C Adapter Device}
>> +
>> +virtio-i2c is a virtual I2C adapter device. It provides a way to flexibly
>> +organize and use the host I2C slave devices from the guest. By attaching
>> +the host ACPI I2C slave nodes to the virtual I2C adapter device, the guest can
>> +communicate with them without changing or adding extra drivers for these
>> +slave I2C devices.
> Is there a way to identify I2C busses if more than one virtio-i2c device
> is present? For example, imagine a host with 2 I2C busses. How does the
> guest know which virtio-i2c device connects to which host bus?
This virtio-i2c is a master device. The slave devices attached to it can 
be configured
by the backend in the host. These slave devices can be under different 
host I2C master devices.
The guest will see this virtio-i2c master device and its slave devices.

There is a example about the backend which shows how it works

https://projectacrn.github.io/latest/developer-guides/hld/virtio-i2c.html?highlight=i2c
https://github.com/projectacrn/acrn-hypervisor/blob/master/devicemodel/hw/pci/virtio/virtio_i2c.c
>
>> +\begin{lstlisting}
>> +struct virtio_i2c_req {
>> +        le16 addr;
>> +        le32 flags;
> What is the memory layout?
>
> 1. 0x0 addr, 0x2 flags
>
> or
>
> 2. 0x0 addr, 0x4 flags
>
> This is unclear to me. I don't see a general statement in the spec about
> struct field alignment/padding and no details in this new spec change.

Both are OK to me. I used to use "packed" but Michael said there was no 
need to pack it.

https://lkml.org/lkml/2020/9/3/339

So you prefer it to be clear ?

>> +        le16 written;
>> +        le16 read;
>> +        u8 write_buf[];
>> +        u8 read_buf[];
>> +        u8 status;
>> +};
>> +\end{lstlisting}
>> +
>> +The \field{addr} of the request is the address of the I2C slave device.
> https://en.wikipedia.org/wiki/I2c#Addressing_structure suggests there
> are at least 7-bit and 10-bit addressing schemes in I2C. How does this
> map to the little-endian 16-bit addr field?

This field maps to the kernel struct "i2c_msg.addr".

struct virtio_i2c_req  *vmsg;
struct i2c_msg *msg;

vmsg->addr  = cpu_to_le16(msg->addr);

The field in the request can be seen as host byte order
while the link can be seen as the I2C network byte order.
The host driver may take care thisconversion.

>> +The \field{flags} of the request is currently reserved as zero for future
>> +feature extensibility.
>> +
>> +The \field{written} of the request is the number of data bytes in the \field{write_buf}
>> +being written to the I2C slave address.
> This field seems redundant since the device can determine the size of
> write_buf implicitly from the total out buffer size. virtio-blk takes
> this approach.
The read/write are the actual number of data bytes being read from or 
written to the device
which is not determined by the device. So I don't think it is redundant.
>> +The \field{read} of the request is the number of data bytes in the \field{read_buf}
>> +being read from the I2C slave address.
> Same here. virtio-blk doesn't use an explicit read size field because
> the device can determine it.

--------------7FFBBD4BADE774911DA56493
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
    <div class=3D"moz-cite-prefix">On 2020/12/16 23:52, Stefan Hajnoczi
      wrote:<br>
    </div>
    <blockquote type=3D"cite"
      cite=3D"mid:20201216155218.GA720702@stefanha-x1.localdomain">
      <pre class=3D"moz-quote-pre" wrap=3D"">On Wed, Nov 25, 2020 at 01:55:=
18PM +0800, Jie Deng wrote:
</pre>
      <blockquote type=3D"cite">
        <pre class=3D"moz-quote-pre" wrap=3D"">diff --git a/virtio-i2c.tex =
b/virtio-i2c.tex
new file mode 100644
index 0000000..fdb0050
--- /dev/null
+++ b/virtio-i2c.tex
@@ -0,0 +1,139 @@
+\section{I2C Adapter Device}\label{sec:Device Types / I2C Adapter Device}
+
+virtio-i2c is a virtual I2C adapter device. It provides a way to flexibly
+organize and use the host I2C slave devices from the guest. By attaching
+the host ACPI I2C slave nodes to the virtual I2C adapter device, the guest=
 can
+communicate with them without changing or adding extra drivers for these
+slave I2C devices.=20
</pre>
      </blockquote>
      <pre class=3D"moz-quote-pre" wrap=3D"">
Is there a way to identify I2C busses if more than one virtio-i2c device
is present? For example, imagine a host with 2 I2C busses. How does the
guest know which virtio-i2c device connects to which host bus?</pre>
    </blockquote>
    This virtio-i2c is a master device. The slave devices attached to it
    can be configured<br>
    by the backend in the host. These slave devices can be under
    different host I2C master devices.<br>
    The guest will see this virtio-i2c master device and its slave
    devices.<br>
    <p>There is a example about the backend which shows how it works<br>
    </p>
<a class=3D"moz-txt-link-freetext" href=3D"https://projectacrn.github.io/la=
test/developer-guides/hld/virtio-i2c.html?highlight=3Di2c">https://projecta=
crn.github.io/latest/developer-guides/hld/virtio-i2c.html?highlight=3Di2c</=
a><br>
<a class=3D"moz-txt-link-freetext" href=3D"https://github.com/projectacrn/a=
crn-hypervisor/blob/master/devicemodel/hw/pci/virtio/virtio_i2c.c">https://=
github.com/projectacrn/acrn-hypervisor/blob/master/devicemodel/hw/pci/virti=
o/virtio_i2c.c</a><br>
    <blockquote type=3D"cite"
      cite=3D"mid:20201216155218.GA720702@stefanha-x1.localdomain">
      <pre class=3D"moz-quote-pre" wrap=3D"">

</pre>
      <blockquote type=3D"cite">
        <pre class=3D"moz-quote-pre" wrap=3D"">+\begin{lstlisting}
+struct virtio_i2c_req {
+        le16 addr;
+        le32 flags;
</pre>
      </blockquote>
      <pre class=3D"moz-quote-pre" wrap=3D"">
What is the memory layout?

1. 0x0 addr, 0x2 flags

or

2. 0x0 addr, 0x4 flags

This is unclear to me. I don't see a general statement in the spec about
struct field alignment/padding and no details in this new spec change.
</pre>
    </blockquote>
    <p>Both are OK to me. I used to use "packed" but Michael said there
      was no need to pack it.=A0 <br>
    </p>
    <p><a class=3D"moz-txt-link-freetext" href=3D"https://lkml.org/lkml/202=
0/9/3/339">https://lkml.org/lkml/2020/9/3/339</a><br>
    </p>
    <p>So you prefer it to be clear ?<br>
    </p>
    <blockquote type=3D"cite"
      cite=3D"mid:20201216155218.GA720702@stefanha-x1.localdomain">
      <pre class=3D"moz-quote-pre" wrap=3D"">
</pre>
      <blockquote type=3D"cite">
        <pre class=3D"moz-quote-pre" wrap=3D"">+        le16 written;
+        le16 read;
+        u8 write_buf[];
+        u8 read_buf[];
+        u8 status;
+};
+\end{lstlisting}
+
+The \field{addr} of the request is the address of the I2C slave device.
</pre>
      </blockquote>
      <pre class=3D"moz-quote-pre" wrap=3D"">
<a class=3D"moz-txt-link-freetext" href=3D"https://en.wikipedia.org/wiki/I2=
c#Addressing_structure">https://en.wikipedia.org/wiki/I2c#Addressing_struct=
ure</a> suggests there
are at least 7-bit and 10-bit addressing schemes in I2C. How does this
map to the little-endian 16-bit addr field?
</pre>
    </blockquote>
    <p>This field maps to the kernel struct "i2c_msg.addr".</p>
    <pre class=3D"moz-quote-pre" wrap=3D""><span class=3D"fontstyle0">struc=
t virtio_i2c_req</span> *vmsg;
struct i2c_msg *msg;

vmsg-&gt;<span class=3D"fontstyle0">addr</span> =3D cpu_to_le16(msg-&gt;add=
r);

The field in the request can be seen as host byte order
while the link can be seen as the I2C network byte order.
The host driver may take care this <span lang=3D"en">conversion.</span></pr=
e>
    <blockquote type=3D"cite"
      cite=3D"mid:20201216155218.GA720702@stefanha-x1.localdomain">
      <pre class=3D"moz-quote-pre" wrap=3D"">
</pre>
      <blockquote type=3D"cite">
        <pre class=3D"moz-quote-pre" wrap=3D"">+The \field{flags} of the re=
quest is currently reserved as zero for future
+feature extensibility.
+
+The \field{written} of the request is the number of data bytes in the \fie=
ld{write_buf}
+being written to the I2C slave address.
</pre>
      </blockquote>
      <pre class=3D"moz-quote-pre" wrap=3D"">
This field seems redundant since the device can determine the size of
write_buf implicitly from the total out buffer size. virtio-blk takes
this approach.
</pre>
    </blockquote>
    The read/write are the actual number of data bytes being read from
    or written to the device<br>
    which is not determined by the device. So I don't think it is
    redundant.<br>
    <blockquote type=3D"cite"
      cite=3D"mid:20201216155218.GA720702@stefanha-x1.localdomain">
      <pre class=3D"moz-quote-pre" wrap=3D"">
</pre>
      <blockquote type=3D"cite">
        <pre class=3D"moz-quote-pre" wrap=3D"">+The \field{read} of the req=
uest is the number of data bytes in the \field{read_buf}
+being read from the I2C slave address.
</pre>
      </blockquote>
      <pre class=3D"moz-quote-pre" wrap=3D"">
Same here. virtio-blk doesn't use an explicit read size field because
the device can determine it.
</pre>
    </blockquote>
  </body>
</html>

--------------7FFBBD4BADE774911DA56493--

