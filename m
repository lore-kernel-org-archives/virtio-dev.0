Return-Path: <virtio-dev-return-13315-virtio-dev=archiver.kernel.org@lists.oasis-open.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from ws5-mx01.kavi.com (ws5-mx01.kavi.com [34.193.7.191])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E9DD7C001DC
	for <virtio-dev@archiver.kernel.org>; Fri,  7 Jul 2023 13:27:04 +0000 (UTC)
Received: from lists.oasis-open.org (oasis.ws5.connectedcommunity.org [10.110.1.242])
	by ws5-mx01.kavi.com (Postfix) with ESMTP id 0FC132AC7E
	for <virtio-dev@archiver.kernel.org>; Fri,  7 Jul 2023 13:27:03 +0000 (UTC)
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id DB9DC986812
	for <virtio-dev@archiver.kernel.org>; Fri,  7 Jul 2023 13:27:02 +0000 (UTC)
Received: from host09.ws5.connectedcommunity.org (host09.ws5.connectedcommunity.org [10.110.1.97])
	by lists.oasis-open.org (Postfix) with QMQP
	id CDD22986808; Fri,  7 Jul 2023 13:27:02 +0000 (UTC)
Mailing-List: contact virtio-dev-help@lists.oasis-open.org; run by ezmlm
List-ID: <virtio-dev.lists.oasis-open.org>
Sender: <virtio-dev@lists.oasis-open.org>
Precedence: bulk
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id B95DC986809;
	Fri,  7 Jul 2023 13:26:58 +0000 (UTC)
X-Virus-Scanned: amavisd-new at kavi.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Y74qY1GvUkJjdjIJ3EGRoWX4ey0JerX5ALdKrEwj+plHHOlQf112nciC9a/WFgdnBnQK51YgZ/nmK8ngOmgh/OUQFVD+Mk9QFex2hnu376zSIsIYCY9MAtgjjC5cLdhD/zbyqctwQ6pl0la0GDP3OWNfC2HEuA0A/MluJX3Ep1PHhpfW7FYuQfSE2WfEe8NVHGa2+hnxMIUEHJR21eTvPFsAraFDfkU1ILh2p794XitDHTrWDR2vEBf7E6fy/EBnmX8Dj1sM4OOO9KvIwnxyp//wQVuLfR9WAujtEvyLsZs1UBUzw5G3fnwwSS1NiOfpIVNVNY5nzVCRUYgWbMFhGA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=0VRIPY/taciPi3m2qjLZvPB/lW+ZWnt5G9eIOpVafmU=;
 b=bc5EGA2D7de2bTTldUXHe/ZulI4WJ9Bc2hsDVG4zZQdsX7ePNsxq1OyzGkirjXQTyO8BIYQei/Bg03W6J1DLredsjxsHClzeksACSlIhKSEBEQA5EX6EGuZXx52upSXGHUl3/yGr/NBhR/RwO2u270OLIvfa/Kf0jHAXeXjI5TJrNcCUQqbiGFSRABJIDbojYs57qOQEv919OW+OUR9xAikDt7a7S7j21jZe1UqQUBmf/11/mMa5ZdUNLr5d/uwAWh3P5bDF7u1tJP9EBDH37WsBdpek5eFmdxKHK5J2hGpa26ckqK48LbzUs+qc7l0neNDnX0iYSDkibkx6MJNThw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
From: Parav Pandit <parav@nvidia.com>
To: "Michael S. Tsirkin" <mst@redhat.com>
CC: "virtio-comment@lists.oasis-open.org"
	<virtio-comment@lists.oasis-open.org>, "cohuck@redhat.com"
	<cohuck@redhat.com>, "david.edmondson@oracle.com"
	<david.edmondson@oracle.com>, "virtio-dev@lists.oasis-open.org"
	<virtio-dev@lists.oasis-open.org>, "sburla@marvell.com" <sburla@marvell.com>,
	"jasowang@redhat.com" <jasowang@redhat.com>, Yishai Hadas
	<yishaih@nvidia.com>, Maor Gottlieb <maorg@nvidia.com>, Shahaf Shuler
	<shahafs@nvidia.com>
Thread-Topic: [PATCH v12 3/3] admin: Add group member legacy register access
 commands
Thread-Index: AQHZsIa8NKsObqKObke5yxkM3VEKNa+uCmeAgABBWRA=
Date: Fri, 7 Jul 2023 13:26:56 +0000
Message-ID:
 <PH0PR12MB5481B9E319B41225FEAE3BE7DC2DA@PH0PR12MB5481.namprd12.prod.outlook.com>
References: <20230707035401.107855-1-parav@nvidia.com>
 <20230707035401.107855-4-parav@nvidia.com>
 <20230707043229-mutt-send-email-mst@kernel.org>
In-Reply-To: <20230707043229-mutt-send-email-mst@kernel.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH0PR12MB5481:EE_|SJ1PR12MB6170:EE_
x-ms-office365-filtering-correlation-id: 302b60a1-35c0-4aa8-4cac-08db7eedd5ed
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info:
 YZmQETC9YhI38wAxxDwHy2q1kUHlbysAAEe3cF8Z/f8mtDmN7UIs+ug+ZqYR0O9XWVkM4dZygS4TeilaNnlmvmFbb3A0ok6K4V49fp2QNGZwUOP4NEJqNdDgElryG7uRjXTzyl0w+CUyTIDuQr5REPX8dsN+mfb0Q2+c1DQL+myYp4rUQk9BSHy4qKV0wnbPPPc6oZH0jETaS/fp/403lw8poYRT4M/mo1w/9csy4qkAJElMblxa6xdBR60IehuoGNJ/BocZkzpAOAa4/RYLCrnc2eDgbIFU5ArmfWb4faZL2FofQkrI8v/3O6L17C/h7s6JlZPnUvMECe3XDlkmmYNNIwDq5+fHeDDB+gnk0/xTWocwBsVy2za9Ho1LWlP4FVMPSmnCcV0o6J8a+MxbhdrXV4P2JYsZL7q/lX1MXDdi5zclDrSUN2fBXr8tR8c6QG02Z4E4paVrzvE4zxfUqDDLo5KjN4/EHTT5swwd7vURlUm5HGraxtze1uhIUlghW+bEPfOZxVwh+auuC3CHziphkj4ZzfxuMVpKhPe/ZnlmK5nW+/2puNq+QxuRRKrOu+qZ2J+BQjk28SwJvW7OT51MPtM0cQnTR0eL16y4mESrF466IKDCSTDdIzAOr1+u
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR12MB5481.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(366004)(346002)(39860400002)(376002)(396003)(136003)(451199021)(8676002)(8936002)(86362001)(38100700002)(5660300002)(41300700001)(316002)(52536014)(33656002)(4326008)(66446008)(6916009)(66946007)(66556008)(66476007)(76116006)(64756008)(83380400001)(7696005)(122000001)(4744005)(2906002)(38070700005)(478600001)(54906003)(55016003)(9686003)(6506007)(186003)(71200400001)(107886003)(26005);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?a1pQamRQbmxsL1h0RGw2ZEQvek9Mdkh3amlqbi9jVFk5L2dyTFMrT2s5ZEpl?=
 =?utf-8?B?SEFRd1JyNDFiTDdIempPdW9ldVIyLzZaVkJSZ010aWVBQjdYYzhoUHNrZVA3?=
 =?utf-8?B?eGJaRHRDYTJiakRSbXliNGUrU2RzMVFuTXgxbFZUcGhjSDYzT0dwTmtkSjNj?=
 =?utf-8?B?ZzVsRHE4ak8yU3ZtL3FFRWlON1dCUHN4L0RMM0wvUWxjK1o4YkFiYzArZ3c5?=
 =?utf-8?B?dVRqWFQ5OVlQREpKdE5ML2RoZkxIaGUzNmlMNHJ4U0JHelVWOTdIVTNiVkpi?=
 =?utf-8?B?S3QzVmFXRWNYY0x2ZUZCZkEzaG1ucnZjN3kzS0E4cm9IRjhDTkRwZDNUSVQ5?=
 =?utf-8?B?cWh5end1bjlpV2l2NDlza1pkMUdmanU2RjI3NHRlcUFwMjZRRmVtbUpUSTZ0?=
 =?utf-8?B?SGlrTUg1Mi9CaEYvN3lhQXNnNDdXREx3MXFWWlhVa3hpWFFKbHErQ2RLQzhP?=
 =?utf-8?B?eU5qS3h2eTUxSVVJUWRrN3NCVEc1eUNZVDNOTjRJYXRJclUyeVZJR1RXRkpS?=
 =?utf-8?B?L0lGdFcyY0lkb05XU08vM0o4czBsclJ2RnBTb1ZSMVlRTm84ME1BRTBFYTg2?=
 =?utf-8?B?YldpZ09KTUw5RTlHRy9zTHcwV0owZWp4VHJsRzgwekR5azBZNDA4NkFjNzAv?=
 =?utf-8?B?TTVOT1lDR0ZwaDJaU0ZkSmtadG53Z0FOUFNxSHhYVWttM29MT2NYOGNWUUZz?=
 =?utf-8?B?TWQ3UHlxS1NORWFRbXE5eHFudW0vR1pzbTRMWVRvOEdUZlZrb05sajhaS3hN?=
 =?utf-8?B?QXlGM0JBR0JEd09MWWREbWluWUp6dEl1NHA0aGNaRmxHZTFReUFuYmtrcHFv?=
 =?utf-8?B?K2l1V3pyZ1c3UjRONEtEc3VmSzRGclg2bk95akNBUjBiN2dyYzBiSjBNOGFZ?=
 =?utf-8?B?MTlickRObHdqalJsT29mUGFNK0JJMk1URXBpWjZxZUYxUmJsNjFBWXpwc2J0?=
 =?utf-8?B?MWg3TExtclhNbk9vM3FGbE9mY29CclRHV1FJSy9JVUliOWIrM2RicTlZNm5x?=
 =?utf-8?B?TEhuU2Njak94K2RhQ0cxd2FKL3J3NW1hT0VtTEU3cXgvUFBoRDZ6L2V1cXpx?=
 =?utf-8?B?bDIxT3B4SmtGdGExK1ZLVGdvNEhjeWpub3ZaNGZrN2xucDBHTVUvWGlGNEg0?=
 =?utf-8?B?NThZUkJsY2VBeFZnanFhVXBLY2sxQlRONW9ML0NSeHVZVUpSNUhqZEhuSnN1?=
 =?utf-8?B?SE9YM3hzajdHcE16UkZFNkFCd1o3Y2dDSmtlUTJNdlpVY3h1dGdHZkhjaHNP?=
 =?utf-8?B?OHNueDd3VUFWajJFSG90aGpyZDJRam9YMlNvcjlRdXZPbm1XZHNDbmJxUWd5?=
 =?utf-8?B?OGYvVFZJZ0cwaXdTSjFVZ1k5QlFvYlNuNGJYQ2FSbHA2UjI3anVFbUROeDZ1?=
 =?utf-8?B?akRGcDlyM1B0QkVhY25CWkpQSEVZZzAxS1VaTmYvUkltQ05hcWlGOTRwaW4r?=
 =?utf-8?B?SnNzZENPM1ZOMEFkUitpTTdJVlpGWndQeUJTU3NDTzFMbGhwUkkxNHZGcGl0?=
 =?utf-8?B?Q0VEZ3lSQUM1U2RvT3UyaEp6WE9SQ3IrSDliNnU3dXhLc2ErdnpQRDZUWDRI?=
 =?utf-8?B?OXNoMnY2dmxJclZJN3EwZVBnQkJlUTFaTjNjaEQ4MG5mUnhjUWY0SjRRMXU4?=
 =?utf-8?B?WEh4Yjd3eHMrbERYa28rZVZ0bFFCek1yRk5uQjR5Vjlsd1gxRHJ0ODJrdnc0?=
 =?utf-8?B?eC85TmdVeHpUaUtWeXRveVZUcXdWck9Eb2Jzd1ZXYlJXcVJHOG9Yc3lqZGVl?=
 =?utf-8?B?dEViWUNpLzFQMm83VjkzY2QvU1ZWbWo5czlrVkt3bkZNUVcvdXFyNHZkOHhW?=
 =?utf-8?B?cTVvbVFXYWZlcVBkV2s3WG5mcnB1WHZ5dWE0Z2t2TVJuemtlUkREYUpyY0xy?=
 =?utf-8?B?R2RPeFIzWWdiZUxZMDYrSGlsckFnV3pGNHBZOHg0dVYvMVpJa3c1YkpESEZE?=
 =?utf-8?B?VUF3TGExajBNSEhoNWtyUXNwRCt4Smt1TzdrdnozN1M2VkdCZHBiVjJjKzFq?=
 =?utf-8?B?ZkgrN2VialE3bk9RL0NqTEtDVnVJUERrL2tkazlNOU4vWVQvK1J4bjJQQkdi?=
 =?utf-8?B?K2J5djFKMHVUdFhJSWcvZ2VYNnE2azh0K29xUHhTMXF1M1AvLzFGVjhiVjYr?=
 =?utf-8?Q?7eMc=3D?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH0PR12MB5481.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 302b60a1-35c0-4aa8-4cac-08db7eedd5ed
X-MS-Exchange-CrossTenant-originalarrivaltime: 07 Jul 2023 13:26:56.4253
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: y7w6KGSjKeU+17SZdN66B6wnvtTtHQm9ZtB06fXY9r7SJ8/l4/VCGNPNiUpT5u+3J25puBI03TSeKUFyZyw7sQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ1PR12MB6170
Subject: [virtio-dev] RE: [PATCH v12 3/3] admin: Add group member legacy register access
 commands

DQoNCj4gRnJvbTogTWljaGFlbCBTLiBUc2lya2luIDxtc3RAcmVkaGF0LmNvbT4NCj4gU2VudDog
RnJpZGF5LCBKdWx5IDcsIDIwMjMgNTozMSBBTQ0KDQpbLi5dDQo+ID4gK0ZvciBWSVJUSU9fQURN
SU5fQ01EX0xFR0FDWV9ERVZfQ0ZHX1dSSVRFIGFuZA0KPiA+ICtWSVJUSU9fQURNSU5fQ01EX0xF
R0FDWV9ERVZfQ0ZHX1JFQUQgY29tbWFuZHMsIHRoZSBkcml2ZXINCj4gU0hPVUxEIHNldA0KPiA+
ICtcZmllbGR7b2Zmc2V0fSBhbmQgdGhlIGxlbmd0aCBvZiB0aGUgXGZpZWxke2RhdGF9IHRvIHJl
ZmVyIHRvIGENCj4gPiArc2luZ2xlIGZpZWxkIHdpdGhpbiB0aGUgdmlydGlvIGRldmljZS1zcGVj
aWZpYyBjb25maWd1cmF0aW9uLg0KPiA+ICsNCj4gPiArSWYgVklSVElPX0FETUlOX0NNRF9MRUdB
Q1lfTk9USUZZX0lORk8gY29tbWFuZCBpcyBzdXBwb3J0ZWQsIHRoZQ0KPiA+ICtncm91cCBtZW1i
ZXIgZHJpdmVyIFNIT1VMRCB1c2UgdGhlIG5vdGlmaWNhdGlvbiBhZGRyZXNzIHRvIHNlbmQgYQ0K
PiA+ICtkcml2ZXIgbm90aWZpY2F0aW9uIHRvIHRoZSBkZXZpY2UuDQo+IA0KPiBObyBncm91cCBt
ZW1iZXIgZHJpdmVyIGlzIG5vdCBpbnZvbHZlZC4NCk9rLg0KDQo+IEp1c3Qgc2F5IHRoZSBkcml2
ZXIuIEFuZCAiZHJpdmVyIG5vdGlmaWNhdGlvbnMiIC0geW91IHdhbnQgdGhpcyBmb3IgYWxsIG9m
IHRoZW0gbm8/DQo+IA0KRGlkbuKAmXQgdW5kZXJzdGFuZCB0aGUgcXVlc3Rpb24uIA0KRG8geW91
IG1lYW4gImFsbCBkZXZpY2VzIj8NCg==

