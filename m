Return-Path: <virtio-dev-return-12280-virtio-dev=archiver.kernel.org@lists.oasis-open.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from ws5-mx01.kavi.com (ws5-mx01.kavi.com [34.193.7.191])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0DF11C77B75
	for <virtio-dev@archiver.kernel.org>; Tue, 18 Apr 2023 12:09:24 +0000 (UTC)
Received: from lists.oasis-open.org (oasis.ws5.connectedcommunity.org [10.110.1.242])
	by ws5-mx01.kavi.com (Postfix) with ESMTP id 5E4C23E309
	for <virtio-dev@archiver.kernel.org>; Tue, 18 Apr 2023 12:09:23 +0000 (UTC)
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id 525209863FC
	for <virtio-dev@archiver.kernel.org>; Tue, 18 Apr 2023 12:09:23 +0000 (UTC)
Received: from host09.ws5.connectedcommunity.org (host09.ws5.connectedcommunity.org [10.110.1.97])
	by lists.oasis-open.org (Postfix) with QMQP
	id 462C9984043; Tue, 18 Apr 2023 12:09:23 +0000 (UTC)
Mailing-List: contact virtio-dev-help@lists.oasis-open.org; run by ezmlm
List-ID: <virtio-dev.lists.oasis-open.org>
Sender: <virtio-dev@lists.oasis-open.org>
Precedence: bulk
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id 33C299863E3;
	Tue, 18 Apr 2023 12:09:20 +0000 (UTC)
X-Virus-Scanned: amavisd-new at kavi.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ks6K/UHOl3QxBwo3gOAu1090BspYm+WmeyJVDP1dNOBy6Td9b9Ae8PL01Xlii+AwSMGHYsVnbzBJIMzPEtj1OIkN1XeULmv4zDOban7J4lA+vfUwjo6yxD9/J48siW3g/IsfieDEK+RguRqKxWCKjxVEe+yuOJhCKjfTL6SZxFJjyjkVvVwyoEjlzofiXl6fb2zihZCXexu0GNVytt/ayyx4lEjgUrqOYH+L3yCVdGgfCf1FXhkYMmF4Nre1v+C8WSk8t3FYeyWhfctVfff/+AXI/04CgER5daL64M9yxA5KyYzW3fuyNIn8x7Xv2WNjg8i4B8HofxYQOWYteuEfmA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Wj/jCrv3OtpkgE1dnfPseeSs+U9YKZTdjT6WovF6KWI=;
 b=XmwnYg0abn5FSPEGIjdQnHWSzASCHvGXV4DBys8k/V7W7QLWpXeVRCFXtpy39ypBxboBhmVzGpFGy5jSoEevvOOJcFUar3u7fMwyokaGXRmJsQR3NUHnvhQkxsHkZx7H8UGqoXsbs9x7pSL8ceFxB7dxHIkHZOjowcBI1Y8UJ5y/aaJ438XHjKL5Z1KcRbHaoTQIX2b6Wd4lBgOoi7b5MV6dzmWvR3brRAtX9/imhNpYflpB95+fsmmJcigpIMA+MHjCetSm4v/Ujh6slY7FaDNFSpXV0fv2e81TOY+8cluauNd1FGWrFJCt29ITIxVY8Kru45a8HMIaPBs44R7Piw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
From: Parav Pandit <parav@nvidia.com>
To: "Michael S. Tsirkin" <mst@redhat.com>
CC: Jason Wang <jasowang@redhat.com>, "virtio-dev@lists.oasis-open.org"
	<virtio-dev@lists.oasis-open.org>, "cohuck@redhat.com" <cohuck@redhat.com>,
	"virtio-comment@lists.oasis-open.org" <virtio-comment@lists.oasis-open.org>,
	Shahaf Shuler <shahafs@nvidia.com>, Satananda Burla <sburla@marvell.com>,
	Maxime Coquelin <maxime.coquelin@redhat.com>, Yan Vugenfirer <yan@daynix.com>
Thread-Topic: [virtio-comment] Re: [PATCH 09/11] transport-pci: Describe PCI
 MMR dev config registers
Thread-Index:
 AQHZY1tLAUtRpuZtUUOucQPGJlFfkK8flpUAgAQ7nwCAAE6hgIAAAXwAgAAFegCAAAt0AIAALl6AgAEOIwCAAFEgAIAAIPWAgAAcJ4CAASFtgIAABJ4AgAAKJYCAAACFsIAABgyAgAAAT3CAAAYpAIAAAJIAgAAJz4CAAILBcIAAxPiAgAAc1wCAABy4gIAAyrIAgAAhEfCAAIO9gIAAAWdQgAAGhACAAACJcIAEsiqAgADky5CAADloAIAAAFbggABFZwCAAA58oIAAr/mAgAACbiA=
Date: Tue, 18 Apr 2023 12:09:17 +0000
Message-ID:
 <PH0PR12MB5481D2E9CCDD9B813F420A81DC9D9@PH0PR12MB5481.namprd12.prod.outlook.com>
References:
 <CACGkMEvSSXyXQnRs=OiaSJnSEYHP83chL6-B5ZPCGx6TeW9W5Q@mail.gmail.com>
 <PH0PR12MB548135CF5268D979A6D8EDE8DC999@PH0PR12MB5481.namprd12.prod.outlook.com>
 <CACGkMEsHtC99kTTa0TrfeJuhV+F7e-WF7XRgbLJkCBQeAxW8pA@mail.gmail.com>
 <PH0PR12MB5481C29561D5E48BA5D8AEEEDC999@PH0PR12MB5481.namprd12.prod.outlook.com>
 <CACGkMEseO=4xDA+pH2x=CaJ6XyzHEx1ZFO-+uevJH50kLeSWhA@mail.gmail.com>
 <PH0PR12MB5481FFC95F54AD048927FF12DC9C9@PH0PR12MB5481.namprd12.prod.outlook.com>
 <20230417162618-mutt-send-email-mst@kernel.org>
 <PH0PR12MB5481710854882449008F28BDDC9C9@PH0PR12MB5481.namprd12.prod.outlook.com>
 <CACGkMEvPv7eH3+cggcCVZvRCqkNCh_CX+6azNJtdJUDxjjAjwg@mail.gmail.com>
 <PH0PR12MB548113626CD6C7B2F8589042DC9D9@PH0PR12MB5481.namprd12.prod.outlook.com>
 <20230418075401-mutt-send-email-mst@kernel.org>
In-Reply-To: <20230418075401-mutt-send-email-mst@kernel.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH0PR12MB5481:EE_|CY8PR12MB7193:EE_
x-ms-office365-filtering-correlation-id: aee68052-393e-4e5e-0bfd-08db4005bc43
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info:
 O700GrsW1CO9BYfn3V1AFEqa2yyZsIt8U91o94Jff/zq6kExtJPXWDhWqjc7rwQeQAmmBwuTXpZ6gyXcz5Q+y5at9CnF5gTWwn+qtR2vK3MwsQHhkjhl7pcmk/PEDrP9R612d+8RZf3jmrYohKKMM77dvFSCRjBNuY9vO8mkFBB/ZkYhTcglmqo2vRHBmDr8NRA2nETlPatqG4iQudV7+v/xbabsic0yP3Pg+2DZBYf51KAhxS8QWZvV9mmRW79DISLcByEFfTR4+KodS4rhN4W2gsiyQghxQNxZObHRQprhD2ne0uph3YpZnF1Mbq564pjiktQ2wdkpMfRpuPpaTLITubt0V+dYwoWkVhuUQYRoczouhcoolNT2D4WjGWZrfnWONYsvGaWW/sdK+9ydDmOT+qnSfyCrBtdzS43fXyyJVcKRurSbJgJunjeMgbk1Q5mWuT2ZJANbrVdHJyeNl+LUBzyNQw2x2vl/55wBknMU/m/DTepaYp6nOpVISOCt5VOjylfWWqT2csGopqd8pJdY+c2e1d9FSvLk18wEMMeYSv+bweTQMY8el7TRLafCq6Di7J7FIYhTiZeAyal//xSz9X3Lg7JBjmxoqR7xRrpI9/eTtXqrrHnQIweFvgXB
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR12MB5481.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(376002)(396003)(39860400002)(136003)(346002)(366004)(451199021)(26005)(186003)(9686003)(41300700001)(6506007)(54906003)(86362001)(55016003)(6916009)(4326008)(316002)(76116006)(64756008)(66946007)(66446008)(66476007)(66556008)(2906002)(8676002)(8936002)(7696005)(122000001)(52536014)(33656002)(558084003)(38100700002)(38070700005)(5660300002)(71200400001)(478600001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?QS9SWWRKeGYvUHI4Qkc1Q2hyY1cyYkRYOHdRc3F3Ylpubm9SUzBlZmlzZ0gy?=
 =?utf-8?B?TVQ0MmZrVmJWL0VyVm5UaWcyZHY4K1h4a2ZvRnZPeE9NSUFlU0hUa2xPL3dw?=
 =?utf-8?B?V2hDcG9aM01iSG0rS0lKM25wYWJvRDVFNFhpeFAxRDg3aGIyTURXK2pKOXEz?=
 =?utf-8?B?UG1tUkgrU3FuRzRteTIrMEIrTHJXcnU0QzZaWlByVHUyN21hdjZ4NE1UejZq?=
 =?utf-8?B?b3RKajF3b21tTi9NY2txR0c4VXlvQzVjZGY2c1dkZSttRzZHeUNQYVh5U2RL?=
 =?utf-8?B?eDNPbWRDVGs1MDZkNGFoWS9jMDFLMjN6Zm9sd0dJTVlTeEYrTlpYekpZQjZH?=
 =?utf-8?B?RUd1U0tFNnJDb21aczRSU1JwN2dISFRGQ2lneEVtTUVzY3hUa3NWR1ZKeFNI?=
 =?utf-8?B?alZmVVYwWGRsZlgwMHJoV3FPYUxNNlA2aFlndVFYZnVsSDM0MUdFOXZKdWcw?=
 =?utf-8?B?STYxbmpmcXc5K1hkdU1DL090Rm5UdGRCL3oyYTdZa1dYcXJIcmVjNitvaEU2?=
 =?utf-8?B?U0VwN1FyU29rank1SUZYQmhOQ2JEVWlrOU9uMHI2VHA4REp6ekRPNDlMQ0Ja?=
 =?utf-8?B?QytBbU0xWWtTMlg1Y2NGWldRWEYyWSt2TDRSUGR6dTFDUXdlaXNWS080cFV6?=
 =?utf-8?B?TklnYnZtaHBwWTVraUEwSWx4Qk1SU3ZzK1B1Y25wL3lacjBTb3BDYnFDUWo1?=
 =?utf-8?B?cEtOcnZiUHdmOWg0TldwQVVTT0pzdzhtNXBQWVFNNjRiVUdnTm5wUVhPeUwr?=
 =?utf-8?B?ejVhcmZFdXlLSGRyd2RHTHdMQldzVjc2SWtJZUE1Q01TV3BneGQ2NWUzSFVP?=
 =?utf-8?B?dFI2U3U1UUJ6K0dUY1BNQTVoVEgxRGQ0YnZrNnNrMzE2anU0UTlQNWUrNGJz?=
 =?utf-8?B?TWc3NkVQaWtPLzBZUnZOYmhvemo3R1Vnc1g0dk1JSEtmelY0MmwzcnE3bUhw?=
 =?utf-8?B?emI1N3Q2bmkxRk5xQjZadHIrTzdBbUp3NHZWeWpqMXFWSytGY1czRGZnUUF5?=
 =?utf-8?B?Wm13T05odHRBNjFueFJzaUZjcExaa3Z6V3UrdWhXRVM5VjBVMUdOMUwrVXZt?=
 =?utf-8?B?dkh5UWpRSmJMMmZSRkNoaGt2bVZrNTlLaTdSdU1Rd2x1WXRZMmJvNTZjU2gv?=
 =?utf-8?B?MjhoeWsrUVVTenZEZzdQZEVaZFJXZ25kZGtIMStxZVZBcS9nbGdZNHp6cTdy?=
 =?utf-8?B?TUFHN21VM0lmRWhmNWtadGNSMXhDbFdyNHR1TS9ENzN2OW11bTVvdS9xcHFv?=
 =?utf-8?B?M0tmOHUzMVBEbHdFdzR6RlJoZzRYdlNNOTg2VWVTU1BxMWtYRC9xYkk1VXpi?=
 =?utf-8?B?UEpDYjkza2tKcXJGeVB6MFpRY3ZVa056YjBDQk16NUREZTEwTVZrdzdIeDVB?=
 =?utf-8?B?QzZYWVZ4N0ova0Q1b0RQQk14aXFnelZCdElYMTVFL0pzbWhoNmV1RjJrZFQ2?=
 =?utf-8?B?V0NPbk9Db1lIVGpNaXltdDEwc0Z3Vm5VUG96RDhYa3NHOC9WbU9nMGNUeU9Y?=
 =?utf-8?B?V3ZNWWhZMnBOOEIvSE5TYTE3WU9taFF5dFppaUJLeUlpd0dETnVxdi9uRHY1?=
 =?utf-8?B?ZlBsVThqVVE1cXZCalprRUQrZW5qT3hhM0ZpbjRnejdZdjU2Nmx1MmFzQ1Mr?=
 =?utf-8?B?NmpIbEs5Y1ArS2dYZU1CaTNGMXprOFpWNTVsTjI4YzEzUkZmaklST0pQb0hL?=
 =?utf-8?B?QWRlaDN6RWpQM1ZBQmE3UVM1WFhIaUdMN2hXM1J2T3NZclZhQzVyNW5pd1VR?=
 =?utf-8?B?V1huTTdYUXpYTmRHNDdJcFd2TnhlOC9CaTdqZTNuWWQwT1RkdisvZVk2Mlcr?=
 =?utf-8?B?b3phZkZRbmM0dlVVbkFYek5HMlFGWVRlc0g0TnJETFA3MXNTS2VpNHppRHlz?=
 =?utf-8?B?bUxscnZuNHlWdjl0TDFFN2pRMTVRUFNORTJ3cFhJdmNIQWdQWjR2NktOYW52?=
 =?utf-8?B?ZkJDWFdKUmxQVzkxQXY2NUJjZndpbWo3U2VCbGRMZTBubnp2ZFRpT2wyZk5C?=
 =?utf-8?B?OElSeWVhWjZhMktacjBBcCs1QmlxM3lOWkhSVFRJK1JGa0VPMmJlK0xMMXZJ?=
 =?utf-8?B?UzV4Qnd5UDBaVkJDVmZ0VUlUdzRkYzFQWFgxcHFWWVhxaCs1TzdWazR2RDY0?=
 =?utf-8?Q?4Xjw=3D?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH0PR12MB5481.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: aee68052-393e-4e5e-0bfd-08db4005bc43
X-MS-Exchange-CrossTenant-originalarrivaltime: 18 Apr 2023 12:09:18.0098
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: CMn8RtM2AYTgzm7irxn2PlKAQi1RFgytgm0NJEcMzjLhQPOSni4wSTBoc+nEB5U+j9tQSSlZXbsAAw0s49N+xA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR12MB7193
Subject: [virtio-dev] RE: [virtio-comment] Re: [PATCH 09/11] transport-pci: Describe PCI
 MMR dev config registers

DQo+IEZyb206IE1pY2hhZWwgUy4gVHNpcmtpbiA8bXN0QHJlZGhhdC5jb20+DQo+IFNlbnQ6IFR1
ZXNkYXksIEFwcmlsIDE4LCAyMDIzIDc6NTggQU0NCg0KPiBJIHRoaW5rIGluIGFueSBjYXNlLCB1
c2luZyBkZXZpY2UgdGhyb3VnaCB0d28gdHJhbnNwb3J0cyBhdCB0aGUgc2FtZSB0aW1lDQo+IHNo
b3VsZG4ndCBiZSBsZWdhbC4NCg0KUENJIGlzIHRoZSB0cmFuc3BvcnQuDQo=

