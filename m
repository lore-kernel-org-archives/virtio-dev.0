Return-Path: <virtio-dev-return-11892-virtio-dev=archiver.kernel.org@lists.oasis-open.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from ws5-mx01.kavi.com (ws5-mx01.kavi.com [34.193.7.191])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DCC88C76196
	for <virtio-dev@archiver.kernel.org>; Mon,  3 Apr 2023 14:59:04 +0000 (UTC)
Received: from lists.oasis-open.org (oasis.ws5.connectedcommunity.org [10.110.1.242])
	by ws5-mx01.kavi.com (Postfix) with ESMTP id 2B5812AC9E
	for <virtio-dev@archiver.kernel.org>; Mon,  3 Apr 2023 14:59:04 +0000 (UTC)
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id 20A2C9863FA
	for <virtio-dev@archiver.kernel.org>; Mon,  3 Apr 2023 14:59:04 +0000 (UTC)
Received: from host09.ws5.connectedcommunity.org (host09.ws5.connectedcommunity.org [10.110.1.97])
	by lists.oasis-open.org (Postfix) with QMQP
	id 15EAF9863D6; Mon,  3 Apr 2023 14:59:04 +0000 (UTC)
Mailing-List: contact virtio-dev-help@lists.oasis-open.org; run by ezmlm
List-ID: <virtio-dev.lists.oasis-open.org>
Sender: <virtio-dev@lists.oasis-open.org>
Precedence: bulk
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id 02A5B9863DD;
	Mon,  3 Apr 2023 14:58:55 +0000 (UTC)
X-Virus-Scanned: amavisd-new at kavi.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=i1FIMUxznE1V8dVFTeQ4o+UeBnHgNVt4Vn4EqxVTXWiteHOr8wE5S1sToQKtI4WsbUC62NrLJKPNUiLIri9wjWtXFCUhIhtrKiI8RSuYF0bY7sPykaj6tv5w1WmQSc29nZwX5BOC7wdeBho54xP/l0pa6QsqjLK4m1e16oIu6KX5CcTPfbxTgqaXPFLT7AiR6tNrHm9ytUGvLnVS1BxJsr96WLbzb3tGA92RZ1hsB5Ou01mjZA1/9wTY9Hlir0KfLrSQchs/sVT9mTNxoduhgUmvlXm8dVT8W3X/KYRItaOf3Ws8iA5c0LthlLgNpFP5UON9LAY/F+muyyfZY9FPQw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=fnpflWF00AuIPAk7NNka5r5eBWGsVE5SNAcQ6x8eNjc=;
 b=EVX4pIvRuqybLh3ck2UfNPZoLnTIgsxwKb7OTdjd/0COVotlHfhdt549P/nJLu9qpUgtlU9e62M230BLKeqfd0g4gOtxeVcX6FLBiILd26q25lumGllVb+FPy+OWSMhbjasFRPvN8NY1Osk5hGivnJ2XlDtesLFF7DM39Y9utsTmitvv/aUHHhsMnJylp6MvHENB9CJsc/RFO87AHDUTtAgjk4Y+oYWh2iV3pxup8cbnz3u9KsnYxtbKrFW9r8RlauiqbsU1zLSslZG7AXAwvUG4SUMogFERrqs5G8YNVn+2wE4vtYDhvv46HVM+ytgPN6yfIzEloencXo8qOX4xag==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
From: Parav Pandit <parav@nvidia.com>
To: "Michael S. Tsirkin" <mst@redhat.com>
CC: "virtio-dev@lists.oasis-open.org" <virtio-dev@lists.oasis-open.org>,
	"cohuck@redhat.com" <cohuck@redhat.com>,
	"virtio-comment@lists.oasis-open.org" <virtio-comment@lists.oasis-open.org>,
	Shahaf Shuler <shahafs@nvidia.com>, Satananda Burla <sburla@marvell.com>
Thread-Topic: [PATCH 02/11] transport-pci: Move transitional device id to
 legacy section
Thread-Index:
 AQHZY1tGdy5B+WGsTEetsq6ex3gwSa8UcZ4AgAD0knCAAkPqgIACA4iAgAAC4gCAAAIPwA==
Date: Mon, 3 Apr 2023 14:58:52 +0000
Message-ID:
 <PH0PR12MB548146C767C1425EC9CC620CDC929@PH0PR12MB5481.namprd12.prod.outlook.com>
References: <20230330225834.506969-1-parav@nvidia.com>
 <20230330225834.506969-3-parav@nvidia.com>
 <20230331024233-mutt-send-email-mst@kernel.org>
 <PH0PR12MB5481977FD9EF430B891A1F3FDC8F9@PH0PR12MB5481.namprd12.prod.outlook.com>
 <20230402035420-mutt-send-email-mst@kernel.org>
 <PH0PR12MB5481FEAA37D23191932F5C7FDC929@PH0PR12MB5481.namprd12.prod.outlook.com>
 <20230403104716-mutt-send-email-mst@kernel.org>
In-Reply-To: <20230403104716-mutt-send-email-mst@kernel.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH0PR12MB5481:EE_|CY8PR12MB7316:EE_
x-ms-office365-filtering-correlation-id: 6c79fe56-ac48-4bdb-50ca-08db3453f07f
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info:
 vTFgsMaJfd+tffHXM/gBMFgYDMOv1QQMPU857Cv1q4Hdrk5KHsib3NHfDSfAjDesjYqEE7WePI/TzOqblzk635AUzDQuBe93vQD3t9MS/youJwQ8G+wDFJfh2KnVvAehM/FcAffiC3+SIzxOO/fY+72fMsVzkqyyTRAj9Vz4SQ+uhA4AKlqgBT8HzJQOB1GMtOJ4tMq11p1hVWWsr4jHl8cTrzTD1cf4OAinBxx21OwKpjLg7Qirgpkm4ObFgVrmjb90K5p4IFs2UxSRMDDJtNOcGjQTBfdW7jyPnH+GB7ilV57041D989ju/u+qJZbrULLd390LIFSD5xbPBFI9iJnIPVm74o1AECDSRBU+qxlB6AJN3FhmYEvqzf6UnZzXlXViDW7oIFqphbjNSU7FrVTMHjqGuCIxo6QWWb5gtNmsOcMItE6IVyMAGakL4XeSUHgXMoWmn0Pnr0ikMFIWmEgoWGclT6A44S4f35EDhTmpyr5q/KsvLLukApvEYVGslh+8ErxyFjJfdbZ1yfLE8SXo4TcLM9zxqU1vAAkRjHq9FwxI3TrskQEODcTGBs1gz7DfNS+Cj09EtMDpGvoqGNoJgvMaZkUQfzdKdN96NhUZF1ARkpUBuaxHABXjUlwZ
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR12MB5481.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(396003)(136003)(346002)(366004)(39860400002)(376002)(451199021)(38070700005)(122000001)(38100700002)(86362001)(33656002)(55016003)(7696005)(71200400001)(2906002)(186003)(9686003)(4744005)(4326008)(6916009)(76116006)(6506007)(8936002)(66946007)(5660300002)(52536014)(41300700001)(66446008)(478600001)(66476007)(8676002)(64756008)(66556008)(316002)(54906003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?jZELkjbeCs10ycF7rM/KttQqZ6kpSkUBiOYKUVI0B2yU2oL+llFVy3WJUzwP?=
 =?us-ascii?Q?qGzBJv0HJfhFXrrbtelOwrtZ3RGD2xepNaYMDd9K++JKoOnQasUVKKn04Ldb?=
 =?us-ascii?Q?+D6k6eh0KCyyijW8hbQmRRBe6anSSR8UtNXTBODr/9y5mM3Q3+IwbumHaHIa?=
 =?us-ascii?Q?mxm7kmF+veuFeuQ7N5bxEYggYfmUZ4cjke8yoyUDIfphnXlXBeYda3TDCAG1?=
 =?us-ascii?Q?f3ewIHXFWRzK7vFuGeQU277xd5JiD0xCMHNWj23QrwNXVbK64nx8CoX2DaC7?=
 =?us-ascii?Q?NyvzGYqKPtUY5YZRV0n9f9Q9NI1JvpUuEkfykZ7txqBA1n/aJ26dxEjHrEJ0?=
 =?us-ascii?Q?Wws2SASlttPA7F+f8YGxY9Danh/T/IsPN+9pIv5WEc08PQmAxP5ao3uLbg1U?=
 =?us-ascii?Q?VnUYDvOVkNxrSP4EEFjna/k4RBzfhMMbDbPw/laSy2pxuGmmzA69ta138xYo?=
 =?us-ascii?Q?e3seOg3eCIfB0tqlL+mKhTdAGJfryqEXk9+NNM3+VVwmbI/q1LlC4oKeCkG+?=
 =?us-ascii?Q?8J1e/qVIa7LMbGTMeFtLMNUf9YfJBfgDGHRxJ/JkFYfoTq8UdIlmt2W5jPSK?=
 =?us-ascii?Q?5qvRYPyWfXRUirUjkhSM9YiaHux+0dRhDonLis+sJW2grILRiSaY+vA9SLzv?=
 =?us-ascii?Q?hZFbyVuEa32xr+xi5AXd1ZD96tqQh0GkAoPr6847XMGNaew97FFeWYFXrJ38?=
 =?us-ascii?Q?fQVgdohOI/UFY31iRaP8vk39V4kHmytme+gcsAdEN80/E3KwhhK+1Z5gSDmO?=
 =?us-ascii?Q?Z40jOyCtMJHGEEdOdbSiNbhCREcYIB6xj10mWMlj3N1D/uVSOFhTzthyjLQJ?=
 =?us-ascii?Q?sjED6duVfT2IpUX+fN+GF5EG+KpvO6hWQseU8fs2AvzCBOF/nF8pY2n8FR5B?=
 =?us-ascii?Q?/hmeaJR2ikg1neT0BTx9YnMs6S7jI4rw9Lf/5IE45guab72Ri/IEWe9fykF9?=
 =?us-ascii?Q?ZIAdd8/E9KJo7eZPTSl4Hu4sXXfTVuFpjthYQEvQQazkxX6ZCH+rD3vWJ0ed?=
 =?us-ascii?Q?Qj/7YSi8yGOLBaW9R5s2e4KmnFJZYtYXVwq6iIr7Mbi1JE3FtZ43/TBqY3pc?=
 =?us-ascii?Q?104OtcMBRG9K7fctteEDb2uSL5QHcdpnXGVKHXRimXLjYVlPGzcLgCtKAo4C?=
 =?us-ascii?Q?clnazawOYI0cw+j23E6SW7E5GwIN9DQ3B7Lrfcd+ioJdkWoQEmH/a1T4tEWE?=
 =?us-ascii?Q?G4U3Q2LXAI8LffyEw07DUaE7smypKKJH1MCF3xwS2IT2BPtGyHzfGqP4CClJ?=
 =?us-ascii?Q?1D/qgZf0PSIWQz9OutNFGGRJDhjRFV/SFKA+m96n8KekXet151kTTVQ1u2B7?=
 =?us-ascii?Q?Cb8QTrFGL7t5zVWTYTZbd90pas3FPOEp9fM29eZ3DfwrxMd9Im+1NeJ7No1W?=
 =?us-ascii?Q?T4fI/Ylun15GPxiRZNzIIz74vptktH9YtKa5QGGOkj+OFNIYidiw8dkGkilP?=
 =?us-ascii?Q?9RjIYjo6QaitcwChIoXMOj/CpeEdVS1bVG5dJ9fRLFdfghK/z0E//kMbu13d?=
 =?us-ascii?Q?OuDWaqeS2+yPQ9eBP9ouiECmO74+UyO0xHId9yi3OVq37MzsVnzQ/COH5gnI?=
 =?us-ascii?Q?Er7g7geRQ2QM5A0a0gv1RsXd/mPjX9jOOnbu137mmbz+ZAcKB277sjkOnETP?=
 =?us-ascii?Q?589cu3gOJSolC1MVkSACcx0=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH0PR12MB5481.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6c79fe56-ac48-4bdb-50ca-08db3453f07f
X-MS-Exchange-CrossTenant-originalarrivaltime: 03 Apr 2023 14:58:52.4760
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: /PUuI7inCpQjQl7woMrvINcpNPdVy8VQaahH2q7MaFdkhedM0y+BR811i0QWeiK5/Senc2P25RyUmI2R2jvnuA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR12MB7316
Subject: [virtio-dev] RE: [PATCH 02/11] transport-pci: Move transitional device id to
 legacy section


> From: Michael S. Tsirkin <mst@redhat.com>
> Sent: Monday, April 3, 2023 10:50 AM

>=20
> No idea what all this means, sorry.  Please do not move text that affects=
 modern
> drivers to a legacy section. And we've spilled way too much ink on this a=
lready.

I disagree because spec do not describe modern driver and what you are desc=
ribing is not aligned the way current spec is written.
I prefer to avoid mentioning it again the same feature bits section that ta=
lks about Transitional interface.

---------------------------------------------------------------------
To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org

